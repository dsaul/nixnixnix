 
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
#sudo nix-channel --update nixos-unstable


{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in 
{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	imports =
	[ # Include the results of the hardware scan.
		../hardware-configuration.nix
		../includes/bluetooth.nix
		../includes/cifs.nix
		../includes/generic-defaults.nix
		../includes/generic-defaults-gui.nix
		../includes/kde6-wayland.nix
		../includes/locale.nix
		../includes/mdns.nix
		../includes/networking-defaults.nix
		../includes/networking-defaults-gui.nix
		../includes/nvidia.nix
		../includes/printers.nix
		../includes/sound.nix
		../includes/sshd.nix
		../includes/games.nix
		../includes/users/usersandgroups.nix
		../includes/virtualisation.nix
		../includes/xrdp-kde.nix
		../includes/filesystems-documents.nix
		../includes/filesystems-media.nix
		../includes/filesystems-fs.nix
		../includes/fonts.nix
		../includes/tex.nix
		../includes/editors-text.nix
		../includes/editors-daw.nix
		../includes/editors-office.nix
		../includes/editors-notes.nix
		../includes/editors-graphics.nix
		../includes/editors-cad.nix
		../includes/media.nix
		../includes/communication.nix
		../includes/development.nix
		../includes/education.nix
		../includes/utilities-fastflix.nix
		#../container-whishper/whishper.nix
	];
	
	#programs.nix-ld.libraries = with pkgs; [
	#	libGL
	#	xorg.libxcb
	#	xkeyboard_config
	#];
	

	#hardware.nvidia.powerManagement.enable = false;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	# Networking
	networking.hostName = "cornwall-office-dan"; # Define your hostname.
	networking.networkmanager.enable = true;
	#networking.extraHosts =
	#	''
#
	#	0.0.0.0 news.ycombinator.com
	#	0.0.0.0 linkedin.com
	#	0.0.0.0 www.linkedin.com
	#	'';
		
		#		0.0.0.0 www.youtube.com
	#	0.0.0.0 youtube.com

	# Installed Packages
	environment.systemPackages = with pkgs; [
		cudaPackages.cudatoolkit
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

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

	system.stateVersion = "24.05"; # Did you read the comment?

}

