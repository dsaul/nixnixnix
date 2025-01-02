{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."fileserver-smb.age".file = ../secrets/fileserver-smb.age;
	
	
	fileSystems."/mnt/MEDIA-01" = {
		device = "10.5.5.5:/mnt/MEDIA-01";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
	};
}
