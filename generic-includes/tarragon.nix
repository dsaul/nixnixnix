{ config, lib, pkgs, modulesPath, ... }:
let
	unstable = import <nixos-unstable> { 
		system = "x86_64-linux"; 
		config.allowUnfree = true; 
		config.allowBroken = true; 
	};
in 
{
	environment.systemPackages = with pkgs; [
		#basiliskii
		unstable.netatalk
		minivmac
		(pkgs.callPackage ../packages/basiliskii/package.nix {})
		(pkgs.callPackage ../packages/ciderpress2/package.nix {})
		#(pkgs.callPackage ../packages/sheepshaver/package.nix {})
	];	
}
