
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../includes/shares-documents.nix
	];
	
	fileSystems."/" = {
		device = "/dev/disk/by-uuid/fac44483-3ff3-4e5d-95ce-1762ed0fef08";
		fsType = "ext4";
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/3745-F4E4";
		fsType = "vfat";
		options = [ "fmask=0077" "dmask=0077" ];
	};

	swapDevices = [
		{ device = "/dev/disk/by-uuid/efaacaf0-40ad-40ef-8247-8a5c766a5e9a"; }
	];
}
