{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Filesystems
	services.gvfs.enable = true;

	# Enable support for directly running app images.
	programs.appimage.enable = true;
	programs.appimage.binfmt = true;

	
	# Expected Packages
	environment.systemPackages = with pkgs; [
		usbutils
		pciutils
		bc
		htop
		procps
		util-linux
		unzip
		psmisc
		git

		# Filesystems
		xfsprogs
		ntfs3g
		cifs-utils	


	];
	
	programs.nix-ld.enable = true;
}
