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
		../includes/home-manager.nix
		./hardware-configuration.nix
		../includes/cifs.nix
		../includes/generic-defaults.nix
		../includes/locale.nix
		../includes/networking-defaults.nix
		../includes/sshd.nix
		../users/usersandgroups.nix
		../includes/qemu-guest.nix
		../includes/docker.nix
		../services/services-unifi.nix
		../services/services-reverse-proxy.nix
		../services/http-vhost/http-vhost-calendar.dsaul.ca.nix
		../services/http-vhost/http-vhost-esphome.dsaul.ca.nix
		../services/http-vhost/http-vhost-gitea.dsaul.ca.nix
		../services/http-vhost/http-vhost-homeassistant.dsaul.ca.nix
		../services/http-vhost/http-vhost-immich.dsaul.ca.nix
		../services/http-vhost/http-vhost-jellyfin.dsaul.ca.nix
		../services/http-vhost/http-vhost-navidrome.dsaul.ca.nix
		../services/http-vhost/http-vhost-nodered.dsaul.ca.nix
		../services/http-vhost/http-vhost-paperless.dsaul.ca.nix
		../services/http-vhost/http-vhost-seafile.dsaul.ca.nix
		../services/http-vhost/http-vhost-whishper.dsaul.ca.nix
		../stacks/mumble-server/mumble-server.nix
		../stacks/mealie/mealie.nix
	];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/vda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "cornwall-fileserver";
	networking.networkmanager.enable = true;
	
	environment.systemPackages = with pkgs; [
		
	];	
	
	#networking.networkmanager.insertNameservers = [ "1.1.1.1" "9.9.9.9" ];
	
	
	fileSystems."/mnt/DOCUMENTS-01" =
	{
		device = "/dev/disk/by-label/DOCUMENTS-01";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MISC-01" =
	{
		device = "/dev/disk/by-label/MISC-01";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-01" =
	{
		device = "/dev/disk/by-label/MEDIA-01";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-02" =
	{
		device = "/dev/disk/by-label/MEDIA-02";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-03" =
	{
		device = "/dev/disk/by-label/MEDIA-03";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-04" =
	{
		device = "/dev/disk/by-label/MEDIA-04";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-05" =
	{
		device = "/dev/disk/by-label/MEDIA-05";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-06" =
	{
		device = "/dev/disk/by-label/MEDIA-06";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-07" =
	{
		device = "/dev/disk/by-label/MEDIA-07";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-08" =
	{
		device = "/dev/disk/by-label/MEDIA-08";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-09" =
	{
		device = "/dev/disk/by-label/MEDIA-09";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-10" =
	{
		device = "/dev/disk/by-label/MEDIA-10";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-11" =
	{
		device = "/dev/disk/by-label/MEDIA-11";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-12" =
	{
		device = "/dev/disk/by-label/MEDIA-12";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-13" =
	{
		device = "/dev/disk/by-label/MEDIA-13";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-14" =
	{
		device = "/dev/disk/by-label/MEDIA-14";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-15" =
	{
		device = "/dev/disk/by-label/MEDIA-15";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-16" =
	{
		device = "/dev/disk/by-label/MEDIA-16";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-17" =
	{
		device = "/dev/disk/by-label/MEDIA-17";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	fileSystems."/mnt/MEDIA-18" =
	{
		device = "/dev/disk/by-label/MEDIA-18";
		fsType = "xfs";
		options = [ "nofail" "noexec" "nosuid" "x-systemd.device-timeout=4" ];
	};
	
	#showmount -e 10.5.5.5
	services.nfs.server.enable = true;
	services.nfs.server.exports = ''
	/mnt			10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-01	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-02	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-03	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-04	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-05	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-06	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-07	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-08	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-09	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-10	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-11	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-12	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-13	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-14	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-15	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-16	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-17	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	/mnt/MEDIA-18	10.5.5.0/24(rw,nohide,sync,no_subtree_check)
	'';

	networking.firewall.allowedTCPPorts = [ 2049 ];
	

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
