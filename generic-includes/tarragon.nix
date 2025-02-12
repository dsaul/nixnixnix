{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		#basiliskii
		minivmac
		(pkgs.callPackage ../packages/basiliskii/package.nix {})
		(pkgs.callPackage ../packages/ciderpress2/package.nix {})
		#(pkgs.callPackage ../packages/sheepshaver/package.nix {})
	];	
}
