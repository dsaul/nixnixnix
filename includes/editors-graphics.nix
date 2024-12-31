{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		gimp
		krita
		inkscape
		librsvg
	];
}
	

