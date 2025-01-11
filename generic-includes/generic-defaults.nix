{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../services/services-sshd.nix
	];
	
	# Locale
	time.timeZone = "America/Winnipeg";
	i18n.defaultLocale = "en_CA.UTF-8";
	
	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	services.fwupd.enable = true;

	# Filesystems
	services.gvfs.enable = true;

	# Enable support for directly running app images.
	programs.appimage.enable = true;
	programs.appimage.binfmt = true;
	
	boot.binfmt.emulatedSystems = [
		"aarch64-linux"
		"riscv64-linux"
	];

	services.rpcbind.enable = true; # nfs
	
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
		nix-index
		rar
		par2cmdline-turbo
		ffmpeg-headless
		elinks
		nfs-utils
		rpcbind
		
		# Filesystems
		xfsprogs
		ntfs3g
		cifs-utils
		
		#tmp
		patchelf
		bintools
	];
	
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

	nix.settings.auto-optimise-store = true; 
	
	system.copySystemConfiguration = true;
}
