{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."fileserver-smb.age".file = ../secrets/fileserver-smb.age;
	
	fileSystems."/mnt/MISC-01" = {
		device = "//10.5.5.10/MISC-01";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/DOCUMENTS-01" = {
		device = "//10.5.5.10/DOCUMENTS-01";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
}
