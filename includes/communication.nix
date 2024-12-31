{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		#discord
		vesktop
		jami
		element-desktop
		zoom-us
		thunderbird
		hexchat
		mumble
	];	
}
