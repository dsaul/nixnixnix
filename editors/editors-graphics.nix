{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		gimp-with-plugins
		krita
		inkscape
		librsvg
	];
}
	

