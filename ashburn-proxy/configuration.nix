
{ config, lib, pkgs, ... }:
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
		../hardware/hardware-qemu-guest.nix
		
		# Users
		../users/usersandgroups.nix
		
		# Services
		../services/services-reverse-proxy.nix
		
		# System
		../system/system-docker.nix
		
		# Other
		../generic-includes/generic-defaults.nix
		../generic-includes/networking-defaults.nix
	];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	
	boot.kernel.sysctl = {
		"fs.inotify.max_user_watches" = "1048576"; # 2 times the default 8192
		"vm.overcommit_memory" = "1"; # redis
	};

	networking.hostName = "ashburn-proxy";
	# networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

	environment.systemPackages = with pkgs; [
		
	];	

	
	system.stateVersion = "24.11"; # Don't change.
}
