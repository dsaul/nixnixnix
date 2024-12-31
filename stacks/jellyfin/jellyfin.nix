{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "jellyfin";
	UID = "0";
	GID = "0";
in
{
	#imports = [
	#	../../services/http-vhost/http-vhost-mealie.dsaul.ca.nix
	#];
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  ${packageName}:
    user: "${UID}:${GID}"
    image: jellyfin/jellyfin
    container_name: ${packageName}
    network_mode: "host"
    ports:
      - "8096:8096"
    volumes:
      - /var/stacks/${packageName}/data-config:/config
      - /var/stacks/${packageName}/data-cache:/cache
      - /srv/MEDIA-01:/srv/MEDIA-01:ro
      - /srv/MEDIA-02:/srv/MEDIA-02:ro
      - /srv/MEDIA-03:/srv/MEDIA-03:ro
      - /srv/MEDIA-04:/srv/MEDIA-04:ro
      - /srv/MEDIA-05:/srv/MEDIA-05:ro
      - /srv/MEDIA-06:/srv/MEDIA-06:ro
      - /srv/MEDIA-07:/srv/MEDIA-07:ro
      - /srv/MEDIA-08:/srv/MEDIA-08:ro
      - /srv/MEDIA-09:/srv/MEDIA-09:ro
      - /srv/MEDIA-10:/srv/MEDIA-10:ro
      - /srv/MEDIA-11:/srv/MEDIA-11:ro
      - /srv/MEDIA-12:/srv/MEDIA-12:ro
      - /srv/MEDIA-13:/srv/MEDIA-13:ro
      - /srv/MEDIA-14:/srv/MEDIA-14:ro
      - /srv/MEDIA-15:/srv/MEDIA-15:ro
      - /srv/MEDIA-16:/srv/MEDIA-16:ro
      - /srv/MEDIA-17:/srv/MEDIA-17:ro
      - /srv/MEDIA-18:/srv/MEDIA-18:ro
      - /srv/MISC-01/Audio/Music:/srv/MISC-01/Audio/Music:ro
    restart: "unless-stopped"
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
	
	config.system.activationScripts.makeWhishperDirs = lib.stringAfter [ "var" ] ''
		mkdir -p /var/stacks/${packageName}/data-config
		chown -R ${UID}:${GID} /var/stacks/${packageName}/data-config
		mkdir -p /var/stacks/${packageName}/data-cache
		chown -R ${UID}:${GID} /var/stacks/${packageName}/data-cache
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 8096 ];
	#config.networking.firewall.allowedUDPPorts = [ 8096 ];
}