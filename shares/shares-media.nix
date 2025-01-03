{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."fileserver-smb.age".file = ../secrets/fileserver-smb.age;
	
	
	fileSystems."/mnt/MEDIA-01" = {
		device = "10.5.5.5:/mnt/MEDIA-01";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-02" = {
		device = "10.5.5.5:/mnt/MEDIA-02";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-03" = {
		device = "10.5.5.5:/mnt/MEDIA-03";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-04" = {
		device = "10.5.5.5:/mnt/MEDIA-04";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-05" = {
		device = "10.5.5.5:/mnt/MEDIA-05";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-06" = {
		device = "10.5.5.5:/mnt/MEDIA-06";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-07" = {
		device = "10.5.5.5:/mnt/MEDIA-07";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-08" = {
		device = "10.5.5.5:/mnt/MEDIA-08";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-09" = {
		device = "10.5.5.5:/mnt/MEDIA-09";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-10" = {
		device = "10.5.5.5:/mnt/MEDIA-10";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-11" = {
		device = "10.5.5.5:/mnt/MEDIA-11";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-12" = {
		device = "10.5.5.5:/mnt/MEDIA-12";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-13" = {
		device = "10.5.5.5:/mnt/MEDIA-13";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-14" = {
		device = "10.5.5.5:/mnt/MEDIA-14";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-15" = {
		device = "10.5.5.5:/mnt/MEDIA-15";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-16" = {
		device = "10.5.5.5:/mnt/MEDIA-16";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-17" = {
		device = "10.5.5.5:/mnt/MEDIA-17";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	fileSystems."/mnt/MEDIA-18" = {
		device = "10.5.5.5:/mnt/MEDIA-18";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" ];
	};
	
	
}
