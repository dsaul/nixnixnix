{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	environment.systemPackages = with pkgs; [
		#discord
		#(discord.override {
		#	# withOpenASAR = true; # can do this here too
		#	withVencord = true;
		#})
		vesktop
		jami
		element-desktop
		zoom-us
		thunderbird
		hexchat
		#nheko
	];	
}
