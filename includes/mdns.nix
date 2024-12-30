{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	services.avahi = { # So we can discover our printer.
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};	
}
