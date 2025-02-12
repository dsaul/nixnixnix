
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../shares/shares-documents.nix
		../shares/shares-media.nix
		../shares/shares-fs.nix
	];
	
	fileSystems."/" = { 
		device = "/dev/disk/by-uuid/20f0d220-69ae-4ef4-b504-36563691258e";
		fsType = "ext4";
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/51E8-2AE6";
		fsType = "vfat";
		options = [ "fmask=0077" "dmask=0077" ];
	};

	swapDevices = [ 
		{ device = "/dev/disk/by-uuid/34a04526-c822-44fd-a9ac-18091a0474ed"; }
	];

	fileSystems."/mnt/Drive2" =
	{
		device = "/dev/disk/by-label/Drive2";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" ];
	};

	fileSystems."/mnt/Scratch" =
	{
		device = "/dev/disk/by-label/Scratch";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" ];
	};
}
