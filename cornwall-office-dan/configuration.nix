{ config, pkgs, ... }:
let
	unstable = import <nixos-unstable> {
		system = "x86_64-linux";
		config.allowUnfree = true;
		config.allowBroken = true;
	};
in 
{
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	imports = [
		./hardware-configuration.nix
		./block-devices.nix
		
		# Nixos
		# nix-channel --add "https://nixos.org/channels/nixos-unstable" "nixos-unstable"
		# nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix
		# nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
		# nix-channel --update
		../nixos/nixos-agenix.nix
		../nixos/nixos-home-manager.nix
		
		# Hardware
		../hardware/hardware-bluetooth.nix
		../hardware/hardware-nvidia.nix
		../hardware/hardware-printers-cornwall.nix
		
		# Users
		../users/usersandgroups.nix
		
		# Editors
		../editors/editors-tex.nix
		../editors/editors-text.nix
		../editors/editors-daw.nix
		../editors/editors-office.nix
		../editors/editors-notes.nix
		../editors/editors-graphics.nix
		../editors/editors-cad.nix
		
		# Services
		#../container-whishper/whishper.nix
		
		# Utilities
		../utilities/utilities-fastflix.nix
		
		# System
		../system/system-virtualisation.nix
		
		# Other
		../generic-includes/generic-defaults.nix
		../generic-includes/generic-defaults-gui.nix
		../generic-includes/kde6-wayland.nix
		../generic-includes/networking-defaults.nix
		../generic-includes/networking-defaults-gui.nix
		../generic-includes/generic-sound.nix
		../generic-includes/generic-games.nix
		
		../generic-includes/xrdp-kde.nix
		../generic-includes/media.nix
		../generic-includes/communication.nix
		../generic-includes/development.nix
		../generic-includes/education.nix
	];
	
	#hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

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
		
	#	0.0.0.0 www.youtube.com
	#	0.0.0.0 youtube.com

	# Installed Packages
	environment.systemPackages = with pkgs; [
		cudaPackages.cudatoolkit
	];
	
	
	
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

	system.stateVersion = "24.05"; # Did you read the comment?

}

