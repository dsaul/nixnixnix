
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
		../../nixos/nixos-agenix.nix
		../../nixos/nixos-home-manager.nix
		
		# Hardware
		../../hardware/hardware-qemu-guest.nix
		
		# Users
		../../users/usersandgroups.nix
		
		# Services
		../../services/services-reverse-proxy.nix
		../../services/http-vhost/http-vhost-homeassistant.dsaul.ca.nix
		../../services/http-vhost/http-vhost-foundryvtt.dsaul.ca.nix
		../../services/http-vhost/http-vhost-airsonic.dsaul.ca.nix
		../../services/http-vhost/http-vhost-www.epsilonlabs.ca.nix
		../../services/http-vhost/http-vhost-www.dsaul.ca.nix
		
		# System
		../../system/system-docker.nix
		
		# Other
		../../generic-includes/generic-defaults.nix
		../../generic-includes/networking-defaults.nix
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

	age.secrets."system-ashburn-proxy-wireguard-private-key.age".file = ../../secrets/system-ashburn-proxy-wireguard-private-key.age;
	networking.wireguard.enable = true;
	networking.wireguard.interfaces = {
		wg0 = {
			ips = [ "172.16.0.5/32" ];
			privateKeyFile = config.age.secrets."system-ashburn-proxy-wireguard-private-key.age".path;
			peers = [
				{
					publicKey = "Y6CpNkRgWV9FOGjkfRFrV0jc8Y4WI6lE13qwMCubHXQ=";
					allowedIPs = [
						"172.16.0.0/24"
						"10.5.5.0/24"
						"10.2.2.0/24"
						"10.3.3.0/24"
						"10.4.4.0/24"
					];
					endpoint = "cornwall.ip.infra.dsaul.ca:51001";
					persistentKeepalive = 60;
				}
			];
		};
	};


	environment.systemPackages = with pkgs; [
		(pkgs.callPackage ../packages/website-dsaul.ca/package.nix {})
	];	

	
	system.stateVersion = "24.11"; # Don't change.
}
