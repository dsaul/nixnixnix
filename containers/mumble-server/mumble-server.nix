{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "mumble-server";
	MUMBLE_CONFIG_SERVER_PASSWORD = "244466666";
	MUMBLE_CONFIG_welcometext = "Welcome to the Winespring Inn";
	MUMBLE_CONFIG_registerName = "The Winespring Inn";
	UID = "0";
	GID = "0";
in
{
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  mumble-server:
    user: "${UID}:${GID}"
    image: mumblevoip/mumble-server:latest
    container_name: mumble
    hostname: mumble
    restart: unless-stopped
    ports:
     - 64738:64738
     - 64738:64738/udp
    volumes:
     - /var/stacks/${packageName}/data:/data
    environment:
      # https://wiki.mumble.info/wiki/Murmur.ini
      - MUMBLE_CONFIG_SERVER_PASSWORD=${MUMBLE_CONFIG_SERVER_PASSWORD}
      - MUMBLE_CONFIG_autobanAttempts=10
      - MUMBLE_CONFIG_autobanTimeframe=120
      - MUMBLE_CONFIG_autobanTime=300
      - MUMBLE_CONFIG_autobanSuccessfulConnections=false
      - MUMBLE_CONFIG_allowping=false
      - MUMBLE_CONFIG_welcometext=${MUMBLE_CONFIG_welcometext}
      - MUMBLE_CONFIG_bonjour=false
      - MUMBLE_CONFIG_registerName=${MUMBLE_CONFIG_registerName}
      - MUMBLE_CONFIG_registerPassword=
      - MUMBLE_UID=${UID}
      - MUMBLE_GID=${GID}
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			UID=${UID} GID=${GID} docker compose -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeWhishperDirs = lib.stringAfter [ "var" ] ''
		mkdir -p /var/stacks/${packageName}/data
		chown -R ${UID}:${GID} /var/stacks/${packageName}/data
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 64738 ];
	config.networking.firewall.allowedUDPPorts = [ 64738 ];
}