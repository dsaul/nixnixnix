{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "home-assistant";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-homeassistant.dsaul.ca.nix
	];
	
	#config.age.secrets."davis-env.age".file = ../../secrets/davis-env.age;
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  homeassistant:
    image: "ghcr.io/home-assistant/home-assistant:2025.1.0"
    container_name: homeassistant
    ports:
     - '8123:8123'
    volumes:
     - ${stacksDataRoot}/${packageName}/data-homeassistant:/config
    restart: unless-stopped
    environment:
     - TZ=America/Winnipeg
    depends_on:
      - mosquitto
      - esphome
      - nodered
  mosquitto:
    image: eclipse-mosquitto:2.0.20
    container_name: mosquitto
    volumes:
    - ${stacksDataRoot}/${packageName}/config-mosquitto:/mosquitto/config
    - ${stacksDataRoot}/${packageName}/data-mosquitto:/mosquitto/data
    ports:
    - "1883:1883"
    - "9001:9001"
    restart: unless-stopped
    environment:
      - TZ=America/Winnipeg
  esphome:
    container_name: esphome
    image: esphome/esphome:2024.12.2
    ports:
     - '6052:6052'
    volumes:
     - ${stacksDataRoot}/${packageName}/data-esphome:/config
    restart: unless-stopped
    environment:
      - TZ=America/Winnipeg
  nodered:
    container_name: nodered
    image: nodered/node-red:4.0.8-20
    ports:
     - '1880:1880'
    volumes:
     - ${stacksDataRoot}/${packageName}/data-nodered:/data
    restart: unless-stopped
    environment:
     - TZ=America/Winnipeg
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
	
	config.system.activationScripts.makeHomeAssistantDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-homeassistant
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-homeassistant
		
		mkdir -p ${stacksDataRoot}/${packageName}/config-mosquitto
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/config-mosquitto
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-mosquitto
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-mosquitto
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-esphome
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-esphome
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-nodered
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-nodered
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 8123 1883 9001 6052 1880 ];
	config.networking.firewall.allowedUDPPorts = [ 8123 1883 9001 6052 1880 ];
}