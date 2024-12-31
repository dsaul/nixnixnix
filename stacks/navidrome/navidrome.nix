{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "navidrome";
	UID = "0";
	GID = "0";
in
{
	imports = [
		../../services/http-vhost/http-vhost-mealie.dsaul.ca.nix
	];
	
	
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
      TZ: 'America/Winnipeg'
      ND_SCANSCHEDULE: 1h
      ND_LOGLEVEL: info
      ND_BASEURL: ""
      ND_LASTFM_ENABLED: true
      ND_LASTFM_APIKEY: cc84840956aa5bfec224b69e9628b57c
      ND_LASTFM_SECRET: d0413083144a3b1aace0f8672d742482
      ND_LASTFM_LANGUAGE: en
      ND_SPOTIFY_ID: 4fb134daf4ac4b439ae556f30cb591e8
      ND_SPOTIFY_SECRET: 85178ea193ad42aead8d551e3bdc630c
      ND_REVERSEPROXYUSERHEADER: Remote-User
      ND_REVERSEPROXYWHITELIST: 10.0.0.0/8
    volumes:
      - "/var/stacks/${packageName}/data-navidrome:/data"
      - "/srv/MISC-01/Audio/Music:/music:ro"
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
	
	config.system.activationScripts.makeWhishperDirs = lib.stringAfter [ "var" ] ''
		mkdir -p /var/stacks/${packageName}/data-navidrome
		chown -R ${UID}:${GID} /var/stacks/${packageName}/data-navidrome
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 4533 ];
	#config.networking.firewall.allowedUDPPorts = [ 4533 ];
}