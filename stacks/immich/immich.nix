{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "immich";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-immich.dsaul.ca.nix
	];
	
	config.age.secrets."immich-env.age".file = ../../secrets/immich-env.age;
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
#
# WARNING: Make sure to use the docker-compose.yml of the current release:
#
# https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
#
# The compose file on main may not be compatible with the latest release.
#
services:
  immich-server:
    container_name: immich_server
    user: "${UID}:${GID}"
    image: ghcr.io/immich-app/immich-server:v1.122.2
    volumes:
      - ${stacksDataRoot}/${packageName}/data-library:/usr/src/app/upload
    ports:
      - 2283:2283
    depends_on:
      - redis
      - database
    environment:
      PUID: ${UID}
      PGID: ${GID}
      IMMICH_VERSION: ''${IMMICH_VERSION}
      DB_PASSWORD: ''${DB_PASSWORD}
      DB_USERNAME: ''${DB_USERNAME}
      DB_DATABASE_NAME: ''${DB_DATABASE_NAME}
      DB_HOSTNAME: ''${DB_HOSTNAME}
    restart: always
    healthcheck:
      disable: false

  immich-machine-learning:
    container_name: immich_machine_learning
    user: "${UID}:${GID}"
    # For hardware acceleration, add one of -[armnn, cuda, openvino] to the image tag.
    # Example tag: ''${IMMICH_VERSION:-release}-cuda
    image: ghcr.io/immich-app/immich-machine-learning:''${IMMICH_VERSION:-release}
    # extends: # uncomment this section for hardware acceleration - see https://immich.app/docs/features/ml-hardware-acceleration
    #   file: hwaccel.ml.yml
    #   service: cpu # set to one of [armnn, cuda, openvino, openvino-wsl] for accelerated inference - use the `-wsl` version for WSL2 where applicable
    volumes:
      - ${stacksDataRoot}/${packageName}/model-cache:/cache
    environment:
      PUID: ${UID}
      PGID: ${GID}
    restart: always
    healthcheck:
      disable: false

  redis:
    container_name: immich_redis
    image: docker.io/redis:6.2-alpine@sha256:e3b17ba9479deec4b7d1eeec1548a253acc5374d68d3b27937fcfe4df8d18c7e
    volumes:
     - ${stacksDataRoot}/${packageName}/data-redis:/data
    healthcheck:
      test: redis-cli ping || exit 1
    restart: always

  database:
    container_name: immich_postgres
    image: registry.hub.docker.com/tensorchord/pgvecto-rs:pg14-v0.2.0@sha256:90724186f0a3517cf6914295b5ab410db9ce23190a2d9d0b9dd6463e3fa298f0
    environment:
      POSTGRES_PASSWORD: ''${DB_PASSWORD}
      POSTGRES_USER: ''${DB_USERNAME}
      POSTGRES_DB: ''${DB_DATABASE_NAME}
    volumes:
      - ${stacksDataRoot}/${packageName}/data-postgres:/var/lib/postgresql/data
    healthcheck:
      test: pg_isready --dbname="''${DB_DATABASE_NAME}" --username="''${DB_USERNAME}" || exit 1; Chksum="$$(psql --dbname="''${DB_DATABASE_NAME}" --username="''${DB_USERNAME}" --tuples-only --no-align --command='SELECT COALESCE(SUM(checksum_failures), 0) FROM pg_stat_database')"; echo "checksum failure count is $$Chksum"; [ "$$Chksum" = '0' ] || exit 1
      interval: 5m
      start_interval: 30s
      start_period: 5m
    command: ["postgres", "-c", "shared_preload_libraries=vectors.so", "-c", 'search_path="$$user", public, vectors', "-c", "logging_collector=on", "-c", "max_wal_size=2GB", "-c", "shared_buffers=512MB", "-c", "wal_compression=on"]
    restart: always
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."immich-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeImmichDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-postgres
		chown -R 999:999 ${stacksDataRoot}/${packageName}/data-postgres
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-library
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-library
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-redis
		chown -R 999:999 ${stacksDataRoot}/${packageName}/data-redis
		
		mkdir -p ${stacksDataRoot}/${packageName}/model-cache
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/model-cache
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 2283 ];
	#config.networking.firewall.allowedUDPPorts = [ 9900 ];
}