{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "mealie";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-mealie.dsaul.ca.nix
	];
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  ${packageName}:
    user: "${UID}:${GID}"
    container_name: ${packageName}
    image: hkotel/mealie:v2.4.1
    restart: always
    volumes:
      - ${stacksDataRoot}/${packageName}/data:/app/data/
    ports:
      - 9091:9000
    environment:
      PUID: ${UID}
      PGID: ${GID}
      ALLOW_SIGNUP: "false"
      LOG_LEVEL: "DEBUG"

      DB_ENGINE: sqlite # Optional: 'sqlite', 'postgres'
      # =====================================
      # Postgres Config
      #POSTGRES_USER: mealie
      #POSTGRES_PASSWORD: mealie
      #POSTGRES_SERVER: postgres
      #POSTGRES_PORT: 5432
      #POSTGRES_DB: mealie
      # =====================================
      # Email Configuration
      # SMTP_HOST=
      # SMTP_PORT=587
      # SMTP_FROM_NAME=Mealie
      # SMTP_AUTH_STRATEGY=TLS # Options: 'TLS', 'SSL', 'NONE'
      # SMTP_FROM_EMAIL=
      # SMTP_USER=
      # SMTP_PASSWORD=
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeMealieDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 9091 ];
	#config.networking.firewall.allowedUDPPorts = [ 9091 ];
}