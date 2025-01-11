{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "airsonic-advanced";
	UID = "990";
	GID = "990";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-airsonic.dsaul.ca.nix
	];
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  airsonic-advanced:
    image: lscr.io/linuxserver/airsonic-advanced:latest
    container_name: airsonic-advanced
    environment:
      - PUID=${UID}
      - PGID=${GID}
      - TZ=America/Winnipeg
    volumes:
      - ${stacksDataRoot}/${packageName}/airsonic-advanced-config:/config
      - /mnt/MISC-01/Audio/Music:/music:ro
      - ${stacksDataRoot}/${packageName}/airsonic-advanced-playlists:/playlists
      - ${stacksDataRoot}/${packageName}/airsonic-advanced-podcasts:/podcasts
      - ${stacksDataRoot}/${packageName}/airsonic-advanced-media:/media
    ports:
      - 4040:4040
    restart: unless-stopped
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
	
	config.system.activationScripts.makeDavisDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/airsonic-advanced-config
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/airsonic-advanced-config
		
		mkdir -p ${stacksDataRoot}/${packageName}/airsonic-advanced-playlists
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/airsonic-advanced-playlists

        mkdir -p ${stacksDataRoot}/${packageName}/airsonic-advanced-podcasts
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/airsonic-advanced-podcasts

        mkdir -p ${stacksDataRoot}/${packageName}/airsonic-advanced-media
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/airsonic-advanced-media

	'';
	
	config.networking.firewall.allowedTCPPorts = [ 4040 ];
	config.networking.firewall.allowedUDPPorts = [ 4040 ];
}