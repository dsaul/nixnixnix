
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../../shares/shares-media.nix
		../../shares/shares-fs.nix
	];
	
	fileSystems."/" = {
		device = "/dev/disk/by-uuid/615f166d-56af-4b84-92f3-217aa16bf041";
		fsType = "ext4";
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/E65E-639D";
		fsType = "vfat";
		options = [ "fmask=0077" "dmask=0077" ];
	};

	swapDevices = [
		{ device = "/dev/disk/by-uuid/b8a41ae8-af1c-44a8-a381-3ee57fb78524"; }
	];
}
