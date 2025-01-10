{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "pgadmin";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-pgadmin.dsaul.ca.nix
	];
	
	config.age.secrets."pgadmin-env.age".file = ../../secrets/pgadmin-env.age;
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  pgadmin:
    image: dpage/pgadmin4:8.4
    restart: always
    ports:
      - 25003:25003
    volumes:
      # chown -R 5050:5050 ./data-pgadmin4
      - ${stacksDataRoot}/${packageName}/data-pgadmin4:/var/lib/pgadmin
    environment:
      - PUID=${UID}
      - PGID=${GID}
      - PGADMIN_DEFAULT_EMAIL=''${PGADMIN_DEFAULT_EMAIL}
      - PGADMIN_DEFAULT_PASSWORD=''${PGADMIN_DEFAULT_PASSWORD}
      - PGADMIN_LISTEN_PORT=25003
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."pgadmin-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makePgAdminDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-pgadmin4
		chown -R 5050:5050 ${stacksDataRoot}/${packageName}/data-pgadmin4
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 25003 ];
	config.networking.firewall.allowedUDPPorts = [ 25003 ];
}