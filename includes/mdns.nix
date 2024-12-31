{ config, lib, pkgs, modulesPath, ... }:

{
	services.avahi = { # So we can discover our printer.
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};	
}
