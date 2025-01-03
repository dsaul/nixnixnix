{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "jellyfin";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-jellyfin.dsaul.ca.nix
	];
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  ${packageName}:
    user: "${UID}:${GID}"
    image: jellyfin/jellyfin
    container_name: ${packageName}
    ports:
      - 8096:8096
      - 8920:8920
      - 1900:1900/udp
      - 7359:7359/udp
    volumes:
      - ${stacksDataRoot}/${packageName}/data-config:/config
      - ${stacksDataRoot}/${packageName}/data-cache:/cache
      - /mnt/MEDIA-01:/mnt/MEDIA-01:ro
      - /mnt/MEDIA-02:/mnt/MEDIA-02:ro
      - /mnt/MEDIA-03:/mnt/MEDIA-03:ro
      - /mnt/MEDIA-04:/mnt/MEDIA-04:ro
      - /mnt/MEDIA-05:/mnt/MEDIA-05:ro
      - /mnt/MEDIA-06:/mnt/MEDIA-06:ro
      - /mnt/MEDIA-07:/mnt/MEDIA-07:ro
      - /mnt/MEDIA-08:/mnt/MEDIA-08:ro
      - /mnt/MEDIA-09:/mnt/MEDIA-09:ro
      - /mnt/MEDIA-10:/mnt/MEDIA-10:ro
      - /mnt/MEDIA-11:/mnt/MEDIA-11:ro
      - /mnt/MEDIA-12:/mnt/MEDIA-12:ro
      - /mnt/MEDIA-13:/mnt/MEDIA-13:ro
      - /mnt/MEDIA-14:/mnt/MEDIA-14:ro
      - /mnt/MEDIA-15:/mnt/MEDIA-15:ro
      - /mnt/MEDIA-16:/mnt/MEDIA-16:ro
      - /mnt/MEDIA-17:/mnt/MEDIA-17:ro
      - /mnt/MEDIA-18:/mnt/MEDIA-18:ro
      - /mnt/MISC-01/Audio/Music:/mnt/MISC-01/Audio/Music:ro
    restart: "always"
    environment:
      PUID: ${UID}
      PGID: ${GID}
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
	
	config.system.activationScripts.makeJellyfinDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-config
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-config
		mkdir -p ${stacksDataRoot}/${packageName}/data-cache
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-cache
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 8096 8920 ];
	config.networking.firewall.allowedUDPPorts = [ 1900 7359 ];
}