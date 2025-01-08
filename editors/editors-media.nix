{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		kid3-qt
		mkvtoolnix
		metamorphose2
		handbrake
		flac
		makemkv
	];
}
	

