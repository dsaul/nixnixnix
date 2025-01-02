{ config, lib, pkgs, modulesPath, ... }:

{
	fileSystems."/mnt/MISC-01" = {
		device = "10.5.5.5:/mnt/MISC-01";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" "nofail" "soft" ];
	};
	
	fileSystems."/mnt/DOCUMENTS-01" = {
		device = "10.5.5.5:/mnt/DOCUMENTS-01";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" "nofail" "soft" ];
	};
}
