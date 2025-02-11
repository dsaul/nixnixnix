{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		#basiliskii
		(pkgs.callPackage ../packages/basiliskii/package.nix {})
	];	
}
