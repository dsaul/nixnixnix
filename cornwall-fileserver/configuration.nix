# nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix
# nix-channel --update nixos-unstable

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in 
{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	
	imports =
	[
		../includes/agenix.nix
		./hardware-configuration.nix
		../includes/cifs.nix
		../includes/generic-defaults.nix
		../includes/locale.nix
		../includes/networking-defaults.nix
		../includes/sshd.nix
		../users/usersandgroups.nix
		../includes/qemu-guest.nix
		../includes/services-unifi.nix
		../includes/services-reverse-proxy.nix
	];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/vda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "cornwall-fileserver";
	networking.networkmanager.enable = true;
	
	environment.systemPackages = with pkgs; [
		
	];	
	
	networking.networkmanager.insertNameservers = [ "1.1.1.1" "9.9.9.9" ];
	

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
