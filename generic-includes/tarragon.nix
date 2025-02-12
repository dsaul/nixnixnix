{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		#basiliskii
		(pkgs.callPackage ../packages/basiliskii/package.nix {})
		(pkgs.callPackage ../packages/sheepshaver/package.nix {})
	];	
}
