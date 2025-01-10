{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "dbsysdb";
	UID = "0";
	GID = "0";
	stacksDataRoot = "/mnt/DOCUMENTS-01/stacks";
in
{
	config.age.secrets."dbsysdb-env.age".file = ../../secrets/dbsysdb-env.age;
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  postgres:
    image: postgres:17.2
    restart: always
    # set shared memory limit when using docker-compose
    shm_size: 128mb
    # or set shared memory limit when deploy via swarm stack
    #volumes:
    #  - type: tmpfs
    #    target: /dev/shm
    #    tmpfs:
    #      size: 134217728 # 128*2^20 bytes = 128Mb
    environment:
      POSTGRES_PASSWORD: ''${POSTGRES_PASSWORD}
    volumes:
     - ${stacksDataRoot}/${packageName}/data-postgres:/var/lib/postgresql/data
    ports:
      - 25001:5432
'';
	
	config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose --env-file ${config.age.secrets."dbsysdb-env.age".path} -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};
	
	config.system.activationScripts.makeDBsysdbDirs = lib.stringAfter [ "var" ] ''
		mkdir -p ${stacksDataRoot}/${packageName}/data-postgres
		chown -R 999:999 ${stacksDataRoot}/${packageName}/data-postgres
	'';
	
	config.networking.firewall.allowedTCPPorts = [ 25001 ];
	config.networking.firewall.allowedUDPPorts = [ 25001 ];
}