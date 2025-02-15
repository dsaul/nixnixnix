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
	
	
	environment.etc."tarragon/libpython.so".source = "${pkgs.python312Full}/lib/libpython3.12.so";
	environment.etc."tarragon/site-packages/numpy".source = "${pkgs.python312Packages.numpy}/lib/python3.12/site-packages/numpy";
	environment.etc."tarragon/site-packages/numpy-1.26.4.dist-info".source = "${pkgs.python312Packages.numpy}/lib/python3.12/site-packages/numpy-1.26.4.dist-info";
}
