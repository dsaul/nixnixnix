
{ config, lib, pkgs, modulesPath, ... }:

{
	services.samba = {
		settings = {
			Scans = {
				browseable = "no";  # note: each home will be browseable; the "homes" share will not.
				"read only" = "no";
				"guest ok" = "no";
				"path" = "/mnt/DOCUMENTS-01/Unsorted Scans";
			};
			Windows = {
				browseable = "yes";  # note: each home will be browseable; the "homes" share will not.
				"read only" = "no";
				"guest ok" = "no";
				"path" = "/mnt/MISC-01/Software/Windows";
			};
		};
	};
	
	
}
