#sudo nix-channel --add "https://nixos.org/channels/nixos-unstable" "nixos-unstable"
#sudo nix-channel --update "nixos-unstable"

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
		../includes/agenix.nix
		../includes/home-manager.nix
		../includes/hardware-bluetooth.nix
		../services/services-samba.nix
		../includes/generic-defaults.nix
		../includes/generic-defaults-gui.nix
		../includes/kde6-wayland.nix
		../includes/networking-defaults.nix
		../includes/networking-defaults-gui.nix
		../includes/hardware-nvidia.nix
		../includes/printers.nix
		../includes/generic-sound.nix
		../services/services-sshd.nix
		../includes/games.nix
		../users/usersandgroups.nix
		../includes/editors-daw.nix
		../includes/media.nix
		../includes/communication.nix
		../includes/subwoofer-virtual-sink.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.consoleLogLevel = 3; # STFU about ACPI errors.


	# Networking
	networking.hostName = "cornwall-tv"; # Define your hostname.
	networking.networkmanager.enable = true;
	
	environment.systemPackages = with pkgs; [

	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

	system.stateVersion = "24.05"; # Did you read the comment?

}

