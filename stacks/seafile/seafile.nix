{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "seafile";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-seafile.dsaul.ca.nix
	];
	
	config.age.secrets."seafile-env.age".file = ../../secrets/seafile-env.age;
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  db:
    image: mariadb:10.11
    container_name: ${packageName}-mariadb
    user: "${UID}:${GID}"
    environment:
      PUID: ${UID}
      PGID: ${GID}
      MYSQL_ROOT_PASSWORD: ''${MYSQL_ROOT_PASSWORD}
      MYSQL_LOG_CONSOLE: ''${MYSQL_LOG_CONSOLE}
      MARIADB_AUTO_UPGRADE: 1
    volumes:
      - ${stacksDataRoot}/${packageName}/data-mariadb:/var/lib/mysql
    restart: always

  memcached:
    image: memcached:1.6.18
    container_name: ${packageName}-memcached
    entrypoint: memcached -m 256
    restart: always

  ${packageName}:
    image: seafileltd/seafile-mc:11.0-latest
    container_name: ${packageName}
    user: "${UID}:${GID}"
    environment:
      PUID: ${UID}
      PGID: ${GID}
      DB_HOST: ''${DB_HOST}
      DB_ROOT_PASSWD: ''${DB_ROOT_PASSWD}
      TIME_ZONE: ''${TIME_ZONE}
      SEAFILE_SERVER_HOSTNAME: ''${SEAFILE_SERVER_HOSTNAME}
	  SEAFILE_ADMIN_EMAIL: ''${SEAFILE_ADMIN_EMAIL}
	  SEAFILE_ADMIN_PASSWORD: ''${SEAFILE_ADMIN_PASSWORD}
	  SEAFILE_SERVER_LETSENCRYPT: ''${SEAFILE_SERVER_LETSENCRYPT}
    ports:
      - "3900:80"
#     - "443:443"  # If https is enabled, cancel the comment.
    volumes:
      - ${stacksDataRoot}/${packageName}/data-seafile:/shared
    depends_on:
      - db
      - memcached
    restart: always
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."seafile-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeWhishperDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-mariadb
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-mariadb
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-seafile
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-seafile
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 3900 ];
	#config.networking.firewall.allowedUDPPorts = [ 3900 ];
}