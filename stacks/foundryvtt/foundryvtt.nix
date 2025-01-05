{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "foundry";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-foundryvtt.dsaul.ca.nix
	];
	
	config.age.secrets."foundry-env.age".file = ../../secrets/foundry-env.age;
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  foundry:
    image: felddy/foundryvtt:release
    hostname: foundry
    volumes:
      - ./data-foundryvtt:/data
    environment:
      - FOUNDRY_PASSWORD=''${FOUNDRY_PASSWORD}
      - FOUNDRY_USERNAME=''${FOUNDRY_USERNAME}
      - FOUNDRY_ADMIN_KEY=''${FOUNDRY_ADMIN_KEY}
      - FOUNDRY_HOSTNAME=''${FOUNDRY_HOSTNAME}
    ports:
      - '30000:30000'
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."foundry-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeFoundryDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-foundryvtt
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-foundryvtt
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 30000 ];
	#config.networking.firewall.allowedUDPPorts = [ 30000 ];
}