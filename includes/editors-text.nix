{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	environment.systemPackages = with pkgs; [
		gedit
		vim
		kate
	];	
}