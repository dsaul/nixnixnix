{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "kms";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  ${packageName}:
    image: pykmsorg/py-kms:latest
    container_name: ${packageName}
    restart: "always"
    environment:
      TZ: America/Winnipeg
    ports:
      - "1688:1688"
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
	
	
	
	config.networking.firewall.allowedTCPPorts = [ 1688 ];
	config.networking.firewall.allowedUDPPorts = [ 1688 ];
}