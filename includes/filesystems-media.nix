{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	age.secrets."fileserver-smb.age".file = ../secrets/fileserver-smb.age;
	
	fileSystems."/mnt/MEDIA-01" = {
		device = "//10.5.5.10/MEDIA-01";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-02" = {
		device = "//10.5.5.10/MEDIA-02";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-03" = {
		device = "//10.5.5.10/MEDIA-03";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-04" = {
		device = "//10.5.5.10/MEDIA-04";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-05" = {
		device = "//10.5.5.10/MEDIA-05";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-06" = {
		device = "//10.5.5.10/MEDIA-06";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-07" = {
		device = "//10.5.5.10/MEDIA-07";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-08" = {
		device = "//10.5.5.10/MEDIA-08";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-09" = {
		device = "//10.5.5.10/MEDIA-09";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-10" = {
		device = "//10.5.5.10/MEDIA-10";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-11" = {
		device = "//10.5.5.10/MEDIA-11";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-12" = {
		device = "//10.5.5.10/MEDIA-12";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-13" = {
		device = "//10.5.5.10/MEDIA-13";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-14" = {
		device = "//10.5.5.10/MEDIA-14";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-15" = {
		device = "//10.5.5.10/MEDIA-15";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-16" = {
		device = "//10.5.5.10/MEDIA-16";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-17" = {
		device = "//10.5.5.10/MEDIA-17";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-18" = {
		device = "//10.5.5.10/MEDIA-18";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=${config.age.secrets."fileserver-smb.age".path},uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};	
}
