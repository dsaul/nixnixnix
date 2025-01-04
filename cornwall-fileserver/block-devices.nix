
{ config, lib, pkgs, modulesPath, ... }:

{
	fileSystems."/" = {
		device = "/dev/disk/by-uuid/ac416e88-7728-4560-ba4a-e5dfa6fd4fe2";
		fsType = "xfs";
	};

	swapDevices = [
		{ device = "/dev/disk/by-uuid/15f0cbee-5dc2-4a2b-973d-7d57d41032a8"; }
	];
	
	fileSystems."/mnt/DOCUMENTS-01" = {
		device = "/dev/disk/by-label/DOCUMENTS-01";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MISC-01" = {
		device = "/dev/disk/by-label/MISC-01";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-01" = {
		device = "/dev/disk/by-label/MEDIA-01";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-02" = {
		device = "/dev/disk/by-label/MEDIA-02";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-03" = {
		device = "/dev/disk/by-label/MEDIA-03";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-04" = {
		device = "/dev/disk/by-label/MEDIA-04";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-05" = {
		device = "/dev/disk/by-label/MEDIA-05";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-06" = {
		device = "/dev/disk/by-label/MEDIA-06";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-07" = {
		device = "/dev/disk/by-label/MEDIA-07";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-08" = {
		device = "/dev/disk/by-label/MEDIA-08";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-09" = {
		device = "/dev/disk/by-label/MEDIA-09";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-10" = {
		device = "/dev/disk/by-label/MEDIA-10";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-11" = {
		device = "/dev/disk/by-label/MEDIA-11";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-12" = {
		device = "/dev/disk/by-label/MEDIA-12";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-13" = {
		device = "/dev/disk/by-label/MEDIA-13";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-14" = {
		device = "/dev/disk/by-label/MEDIA-14";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-15" = {
		device = "/dev/disk/by-label/MEDIA-15";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-16" = {
		device = "/dev/disk/by-label/MEDIA-16";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-17" = {
		device = "/dev/disk/by-label/MEDIA-17";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-18" = {
		device = "/dev/disk/by-label/MEDIA-18";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	
	
	fileSystems."/srv/Movies" = {
		device = "overlay";
		fsType = "overlay";
		options = [
			"nofail"
			"lowerdir=/mnt/MEDIA-01/Movies;/mnt/MEDIA-02/Movies"
			#"upperdir=/upper"
			#"workdir=/work"
			"ro"
		];
	};
	
}
