
{ config, lib, pkgs, modulesPath, ... }:

{
	services.samba = {
 		enable = true;
		openFirewall = true;
		settings = {
			global.security = "user";
			homes = {
				browseable = "no";  # note: each home will be browseable; the "homes" share will not.
				"read only" = "no";
				"guest ok" = "no";
			};
		};
	};
}
