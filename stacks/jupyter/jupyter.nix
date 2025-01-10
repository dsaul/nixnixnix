{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "jupyter";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-jupyter.dsaul.ca.nix
	];
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  jupyter:
    image: quay.io/jupyter/datascience-notebook:2024-12-23
    container_name: jupyter
    user: "${UID}:${GID}"
    environment:
      PUID: ${UID}
      PGID: ${GID}
    volumes:
      - ${stacksDataRoot}/${packageName}/data-jupyter-home:/home/jovyan/work
    ports:
      - 8888:8888
    
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
	
	config.system.activationScripts.makeJupyterDirs = lib.stringAfter [ "var" ] ''
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-jupyter-home
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-jupyter-home
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 8888 ];
	config.networking.firewall.allowedUDPPorts = [ 8888 ];
}