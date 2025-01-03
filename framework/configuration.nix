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
		../includes/agenix.nix
		../includes/home-manager.nix
		../includes/hardware-bluetooth.nix
		../services/services-samba.nix
		../includes/generic-defaults.nix
		../includes/generic-defaults-gui.nix
		../includes/kde6-wayland.nix
		../includes/mdns.nix
		../includes/networking-defaults.nix
		../includes/networking-defaults-gui.nix
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
