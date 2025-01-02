# nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
# nix-channel --update
#systemctl status "home-manager-$USER.service"
{ config, lib, pkgs, modulesPath, ... }:

{
	includes = [
		<home-manager/nixos> 
	];
	home-manager.useGlobalPkgs = true;
}
	


