{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		keepassxc
		gparted
		via #keyboard
		vial #keyboard
		qmk
		qmk_hid
		qmk-udev-rules
		
	];
}
	


