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
  ${packageName}-mariadb:
    image: mariadb:10.5
    container_name: ${packageName}-mariadb
    environment:
      MARIADB_ROOT_PASSWORD: ''${MARIADB_ROOT_PASSWORD}
      MARIADB_LOG_CONSOLE: ''${MARIADB_LOG_CONSOLE}
    volumes:
      - ${stacksDataRoot}/${packageName}/seafile-mysql:/var/lib/mysql
    restart: always

  ${packageName}-memcached:
    image: memcached:1.5.6
    container_name: ${packageName}-memcached
    entrypoint: memcached -m 256
    restart: always

  ${packageName}:
    image: seafileltd/seafile-mc:12.0.6
    container_name: ${packageName}
    environment:
      DB_HOST: ''${DB_HOST}
      DB_ROOT_PASSWD: ''${DB_ROOT_PASSWD}
      TIME_ZONE: ''${TIME_ZONE}
      SEAFILE_SERVER_HOSTNAME: ''${SEAFILE_SERVER_HOSTNAME}
    ports:
      - "3900:80"
#     - "443:443"  # If https is enabled, cancel the comment.
    volumes:
      - ${stacksDataRoot}/${packageName}/seafile-data:/shared
    depends_on:
      - ${packageName}-mariadb
      - ${packageName}-memcached
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
		mkdir -p ${stacksDataRoot}/${packageName}/data
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 3900 ];
	#config.networking.firewall.allowedUDPPorts = [ 3900 ];
}