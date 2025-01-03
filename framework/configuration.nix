# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
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
		../hardware/hardware-printers-cornwall.nix
		../generic-includes/generic-sound.nix
		../services/services-sshd.nix
		../generic-includes/generic-games.nix
		../users/usersandgroups.nix
		../generic-includes/virtualisation.nix
		../generic-includes/xrdp-kde.nix
		../editors/editors-tex.nix
		../editors/editors-text.nix
		../editors/editors-daw.nix
		../editors/editors-office.nix
		../editors/editors-notes.nix
		../editors/editors-graphics.nix
		../editors/editors-cad.nix
		../generic-includes/media.nix
		../generic-includes/communication.nix
		../generic-includes/development.nix
		../generic-includes/education.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Networking
	networking.hostName = "framework"; # Define your hostname.
	networking.networkmanager.enable = true;

	# Fingerprint Sensor
	# services.fprintd.enable = true; # currently broken, messes with initial login
	
	# Installed Packages
	environment.systemPackages = with pkgs; [
		fw-ectool # Allows for setting firmware settings.
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?

}
