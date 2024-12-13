{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	permittedInsecurePackages = [
		"olm-3.2.16"
	];

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
		(pidgin.override {
			plugins = [
				pidginPackages.pidgin-otr
				pidginPackages.purple-slack
				pidginPackages.pidgin-latex
				pidginPackages.purple-matrix
				pidginPackages.purple-discord
				pidginPackages.purple-facebook
				pidginPackages.pidgin-opensteamworks
			];
		})
	];	
}
