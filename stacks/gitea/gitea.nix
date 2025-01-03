{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "gitea";
	UID = "1000";
	GID = "1000";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	imports = [
		../../services/http-vhost/http-vhost-gitea.dsaul.ca.nix
	];
	
	config.age.secrets."gitea-env.age".file = ../../secrets/gitea-env.age;
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
networks:
  gitea:
    external: false

services:
  ${packageName}:
    image: gitea/gitea:1.22.4
    container_name: ${packageName}
    environment:
      PUID: ${UID}
      PGID: ${GID}
      USER_UID: ''${UID}
      USER_GID: ''${GID}
      GITEA__database__DB_TYPE: ''${GITEA__database__DB_TYPE}
      GITEA__database__HOST: ''${GITEA__database__HOST}
      GITEA__database__NAME: ''${GITEA__database__NAME}
      GITEA__database__USER: ''${GITEA__database__USER}
      GITEA__database__PASSWD: ''${GITEA__database__PASSWD}
      SSH_LISTEN_PORT: ''${SSH_LISTEN_PORT}
    restart: always
    volumes:
      - ${stacksDataRoot}/${packageName}/data-gitea:/data
    ports:
      - "3067:3067"
      - "6874:6874" #ssh
    depends_on:
      - ${packageName}-postgres

  ${packageName}-postgres:
    image: postgres:14
    container_name: ${packageName}-postgres
    restart: always
    environment:
      PUID: ${UID}
      PGID: ${GID}
      POSTGRES_USER: ''${POSTGRES_USER}
      POSTGRES_PASSWORD: ''${POSTGRES_PASSWORD}
      POSTGRES_DB: ''${POSTGRES_DB}
    volumes:
      - ${stacksDataRoot}/${packageName}/data-postgres:/var/lib/postgresql/data

'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."gitea-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeDavisDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-postgres
		chown -R 999:999 ${stacksDataRoot}/${packageName}/data-postgres
		
		mkdir -p ${stacksDataRoot}/${packageName}/data-gitea
		chown -R ${UID}:${GID} ${stacksDataRoot}/${packageName}/data-gitea
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 3067 6874 ];
	#config.networking.firewall.allowedUDPPorts = [ 9900 ];
}