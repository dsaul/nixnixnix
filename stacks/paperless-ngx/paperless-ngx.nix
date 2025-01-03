{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "paperless-ngx";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-calendar.dsaul.ca.nix
	];
	
	config.age.secrets."paperless-ngx-env.age".file = ../../secrets/paperless-ngx-env.age;
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
# Docker Compose file for running paperless from the Docker Hub.
# This file contains everything paperless needs to run.
# Paperless supports amd64, arm and arm64 hardware.
#
# All compose files of paperless configure paperless in the following way:
#
# - Paperless is (re)started on system boot, if it was running before shutdown.
# - Docker volumes for storing data are managed by Docker.
# - Folders for importing and exporting files are created in the same directory
#   as this file and mounted to the correct folders inside the container.
# - Paperless listens on port 8000.
#
# SQLite is used as the database. The SQLite file is stored in the data volume.
#
# To install and update paperless with this file, do the following:
#
# - Copy this file as 'docker-compose.yml' and the files 'docker-compose.env'
#   and '.env' into a folder.
# - Run 'docker compose pull'.
# - Run 'docker compose run --rm webserver createsuperuser' to create a user.
# - Run 'docker compose up -d'.
#
# For more extensive installation and update instructions, refer to the
# documentation.
services:
  broker:
    user: "${UID}:${GID}"
    image: docker.io/library/redis:7
    restart: unless-stopped
    volumes:
      - ${stacksDataRoot}/${packageName}/data-redis:/data
    environment:
      PUID: ${UID}
      PGID: ${GID}
  tika:
    user: "${UID}:${GID}"
    image: apache/tika:2.9.1.0-full
    restart: unless-stopped
    ports:
      - "9998:9998"
    environment:
      PUID: ${UID}
      PGID: ${GID}
  gotenberg:
    user: "${UID}:${GID}"
    image: gotenberg/gotenberg:7
    restart: unless-stopped
    ports:
      - "9977:3000"
    environment:
      PUID: ${UID}
      PGID: ${GID}
  webserver:
    user: "${UID}:${GID}"
    image: ghcr.io/paperless-ngx/paperless-ngx:latest
    restart: unless-stopped
    depends_on:
      - broker
      - tika
      - gotenberg
    links:
     - broker
     - tika
     - gotenberg
    ports:
      - "9974:8000" #127.0.0.1:
    healthcheck:
      test: ["CMD", "curl", "-fs", "-S", "--max-time", "2", "http://localhost:8000"]
      interval: 30s
      timeout: 10s
      retries: 5
    volumes:
      - ${stacksDataRoot}/${packageName}/data-paperless:/usr/src/paperless/data
      - ${stacksDataRoot}/${packageName}/data-media:/usr/src/paperless/media
      - ${stacksDataRoot}/${packageName}/data-export:/usr/src/paperless/export
      - ${stacksDataRoot}/${packageName}/data-consume:/usr/src/paperless/consume
    environment:
      PUID: ${UID}
      PGID: ${GID}
      PAPERLESS_REDIS: ''${PAPERLESS_REDIS}
      PAPERLESS_CONSUMER_POLLING: ''${PAPERLESS_CONSUMER_POLLING}
      PAPERLESS_TIKA_ENABLED: ''${PAPERLESS_TIKA_ENABLED}
      PAPERLESS_TIKA_ENDPOINT: ''${PAPERLESS_TIKA_ENDPOINT}
      PAPERLESS_OCR_USER_ARGS: ''${PAPERLESS_OCR_USER_ARGS}
      PAPERLESS_TIKA_GOTENBERG_ENDPOINT: ''${PAPERLESS_TIKA_GOTENBERG_ENDPOINT}
      PAPERLESS_USE_X_FORWARD_HOST: ''${PAPERLESS_USE_X_FORWARD_HOST}
      PAPERLESS_USE_X_FORWARD_PORT: ''${PAPERLESS_USE_X_FORWARD_PORT}
      PAPERLESS_URL: ''${PAPERLESS_URL}
      PAPERLESS_SECRET_KEY: ''${PAPERLESS_SECRET_KEY}
      PAPERLESS_TASK_WORKERS: ''${PAPERLESS_TASK_WORKERS}
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."paperless-ngx-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makePaperlessNgxDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-redis
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-redis
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-paperless
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-paperless
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-media
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-media
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-export
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-export
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-consume
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-consume
		chmod -R a+w ${stacksDataRoot}/${packageName}/data-consume
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 9998 9977 9974 ];
	#config.networking.firewall.allowedUDPPorts = [ 9900 ];
}