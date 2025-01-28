# nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix
# nix-channel --update nixos-unstable

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
		../hardware/hardware-qemu-guest.nix
		
		# Users
		../users/usersandgroups.nix
		
		# Editors
		
		# Services
		../services/services-nfs.nix
		./nfs-exports.nix
		../services/services-samba.nix
		./smb-shares.nix
		#../services/services-unifi.nix
		../services/services-reverse-proxy.nix
		../services/services-seafile.nix
		../services/http-vhost/http-vhost-whishper.dsaul.ca.nix
		../services/http-vhost/http-vhost-openwebui.dsaul.ca.nix
		
		# Stacks
		../stacks/mumble-server/mumble-server.nix
		../stacks/mealie/mealie.nix
		../stacks/davis/davis.nix
		../stacks/navidrome/navidrome.nix
		../stacks/jellyfin/jellyfin.nix
		../stacks/gitea/gitea.nix
		../stacks/immich/immich.nix
		../stacks/paperless-ngx/paperless-ngx.nix
		../stacks/home-assistant/home-assistant.nix
		../stacks/foundryvtt/foundryvtt.nix
		../stacks/kms/kms.nix
		../stacks/airsonic-advanced/airsonic-advanced.nix
		../stacks/pgadmin/pgadmin.nix
		../stacks/dbsysdb/dbsysdb.nix
		../stacks/jupyter/jupyter.nix
		
		# System
		../system/system-docker.nix
		
		# Other
		../generic-includes/generic-defaults.nix
		../generic-includes/networking-defaults.nix
		
	];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/vda";
	boot.loader.grub.useOSProber = true;
	
	boot.kernel.sysctl = {
		"fs.inotify.max_user_watches" = "1048576"; # 2 times the default 8192
		"vm.overcommit_memory" = "1"; # redis
	};

	networking.hostName = "cornwall-fileserver";
	networking.networkmanager.enable = true;
	
	environment.systemPackages = with pkgs; [
		
	];	
	
	#networking.networkmanager.insertNameservers = [ "1.1.1.1" "9.9.9.9" ];
	
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}