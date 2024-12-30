{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	environment.systemPackages = with pkgs; [
		gimp
		krita #doesn't work on 4090
		inkscape
		librsvg
	];
}
	

