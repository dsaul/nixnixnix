{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		#basiliskii
		SDL2
		#(pkgs.callPackage ../packages/basiliskii/package.nix {})
	];	
}
