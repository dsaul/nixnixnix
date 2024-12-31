{ config, lib, pkgs, modulesPath, ... }:

{
	virtualisation.docker.enable = true;
	virtualisation.docker.package = pkgs.docker_25;
	virtualisation.docker.liveRestore = false;
}
