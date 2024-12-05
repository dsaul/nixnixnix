# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		../includes/cifs.nix
		../includes/generic-defaults.nix
		../includes/locale.nix
		../includes/networking-defaults.nix
		../includes/sshd.nix
		../includes/usersandgroups.nix


	];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "transmission"; # Define your hostname.
	#networking.networkmanager.enable = true;

	networking = {
		interfaces.ens18 = {
			useDHCP = true;
		};
	};

	#networking.wg-quick.interfaces = {
	#	wg0 = {
	#		address = [ "10.11.162.47" ];
	#		dns = [ "10.0.0.243" "10.0.0.242" ];
	#		privateKeyFile = "/etc/nixos/vm-transmission/secrets-vpn.txt";

	#		peers = [
	#			{
	#				publicKey = "6sG1zN6gjvHv4H9TJkwpTrpyGaFIspPYD2wAfQAEVDc=";
	#				allowedIPs = [ "0.0.0.0/0" ];
	#				endpoint = "156.146.60.140:1337";
	#				persistentKeepalive = 25;
	#			}
	#		];
	#	};
	#};

	services.openvpn.servers = {
		vpn  = { config = '' config //etc/nixos/vm-transmission/austria-aes-256-gcm-tcp-dns.ovpn ''; };
	};


	services.transmission = {
		enable = true; #Enable transmission daemon
		openRPCPort = true; #Open firewall for RPC
		settings = { #Override default settings
			rpc-bind-address = "0.0.0.0"; #Bind to own IP
			rpc-whitelist = "127.0.0.1,10.5.5.*,172.16.0.*"; #Whitelist your remote machine (10.0.0.1 in this example)
			incomplete-dir = "/srv/FS/Filesharing/incomplete";
			download-dir = "/srv/FS/Filesharing/complete";
			watch-dir = "/srv/FS/Filesharing/watch";
			watch-dir-enabled = true;
			trash-original-torrent-files = true;
			incomplete-dir-enabled = true;
			utp-enabled = true;
		};
	};

	environment.systemPackages = with pkgs; [
		transmission_4-qt
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?
}
