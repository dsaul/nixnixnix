{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "navidrome";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-navidrome.dsaul.ca.nix
	];
	
	config.age.secrets."navidrome-env.age".file = ../../secrets/navidrome-env.age;
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
version: "3"
services:
  ${packageName}:
    user: "${UID}:${GID}"
    image: deluan/navidrome:latest
    container_name: ${packageName}
    ports:
      - "4533:4533"
    environment:
      PUID: ${UID}
      PGID: ${GID}
      TZ: ''${TZ}
      ND_SCANSCHEDULE: ''${ND_SCANSCHEDULE}
      ND_LOGLEVEL: ''${ND_LOGLEVEL}
      ND_BASEURL: ''${ND_BASEURL}
      ND_LASTFM_ENABLED: ''${ND_LASTFM_ENABLED}
      ND_LASTFM_APIKEY: ''${ND_LASTFM_APIKEY}
      ND_LASTFM_SECRET: ''${ND_LASTFM_SECRET}
      ND_LASTFM_LANGUAGE: ''${ND_LASTFM_LANGUAGE}
      ND_SPOTIFY_ID: ''${ND_SPOTIFY_ID}
      ND_SPOTIFY_SECRET: ''${ND_SPOTIFY_SECRET}
      ND_REVERSEPROXYUSERHEADER: ''${ND_REVERSEPROXYUSERHEADER}
      ND_REVERSEPROXYWHITELIST: ''${ND_REVERSEPROXYWHITELIST}
    volumes:
      - ${stacksDataRoot}/${packageName}/data-navidrome:/data
      - "/mnt/MISC-01/Audio/Music:/music:ro"
    restart: unless-stopped
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."navidrome-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeNavidromeDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-navidrome
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-navidrome
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 4533 ];
	#config.networking.firewall.allowedUDPPorts = [ 4533 ];
}