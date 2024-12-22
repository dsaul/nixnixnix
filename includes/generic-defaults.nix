{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	services.fwupd.enable = true;

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
	
	services.envfs.enable = true;
	programs.nix-ld.enable = true;
	
	programs.nix-ld.libraries = with pkgs; [
		libGL
		xorg.libxcb
		xkeyboard_config
		libstdcxx5
	];

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

	nix.settings.auto-optimise-store = true; 





}
