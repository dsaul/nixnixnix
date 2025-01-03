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
		../generic-includes/agenix.nix
		../generic-includes/home-manager.nix
		../hardware/hardware-bluetooth.nix
		../services/services-samba.nix
		../generic-includes/generic-defaults.nix
		../generic-includes/generic-defaults-gui.nix
		../generic-includes/kde6-wayland.nix
		../generic-includes/networking-defaults.nix
		../generic-includes/networking-defaults-gui.nix
		../hardware/hardware-nvidia.nix
		../hardware/hardware-printers-cornwall.nix
		../generic-includes/generic-sound.nix
		../services/services-sshd.nix
		../generic-includes/generic-games.nix
		../users/usersandgroups.nix
		../editors/editors-daw.nix
		../generic-includes/media.nix
		../generic-includes/communication.nix
		./subwoofer-virtual-sink.nix
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

