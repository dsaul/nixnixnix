
{ config, lib, pkgs, modulesPath, ... }:

{
	fileSystems."/" = {
		device = "/dev/disk/by-uuid/157ba5cb-2d46-4116-ab08-5d8cfe9f360c";
		fsType = "ext4";
	};

	fileSystems."/boot" = { 
		device = "/dev/disk/by-uuid/92dde60e-a983-4d4f-ab99-b8a2634c782b";
		fsType = "ext4";
	};

	swapDevices = [ 
		{ device = "/dev/disk/by-uuid/562b1d88-15ac-45bb-a196-9bd3f8fc9298"; }
	];

	
}
