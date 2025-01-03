# nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
# nix-channel --update

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
		../includes/home-manager.nix
		../includes/agenix.nix
		../includes/hardware-bluetooth.nix
		../services/services-samba.nix
		../includes/generic-defaults.nix
		../includes/generic-defaults-gui.nix
		../includes/kde6-wayland.nix
		../includes/mdns.nix
		../includes/networking-defaults.nix
		../includes/networking-defaults-gui.nix
		../includes/hardware-nvidia.nix
		../includes/printers.nix
		../includes/generic-sound.nix
		../services/services-sshd.nix
		../includes/games.nix
		../users/usersandgroups.nix
		../includes/virtualisation.nix
		../includes/xrdp-kde.nix
		../includes/editors-tex.nix
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
	
	#hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	# Networking
	networking.hostName = "cornwall-office-dan"; # Define your hostname.
	networking.networkmanager.enable = true;
	
	#networking.extraHosts = ''
	#10.5.5.5 calendar.dsaul.ca
	#'';
	
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

