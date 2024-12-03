# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#sudo nix-channel --add "https://nixos.org/channels/nixos-unstable" "nixos-unstable"
#sudo nix-channel --update "nixos-unstable"


{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in
{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		../includes/bluetooth.nix
		../includes/cifs.nix
		../includes/generic-defaults.nix
		../includes/generic-defaults-gui.nix
		../includes/kde6-wayland.nix
		../includes/locale.nix
		#../includes/mdns.nix
		../includes/networking-defaults.nix
		../includes/networking-defaults-gui.nix
		../includes/nvidia.nix
		#../includes/printers.nix
		../includes/sound.nix
		../includes/sshd.nix
		../includes/games.nix
		../includes/usersandgroups.nix
		#../includes/virtualisation.nix
		#../includes/xrdp-kde.nix
		#../includes/filesystems-documents.nix
		../includes/filesystems-media.nix
		../includes/filesystems-fs.nix
		../includes/fonts.nix
		#../includes/tex.nix
		#../includes/editors-text.nix
		#../includes/editors-daw.nix
		#../includes/editors-office.nix
		#../includes/editors-notes.nix
		#../includes/editors-graphics.nix
		#../includes/editors-cad.nix
		../includes/media.nix
		../includes/communication.nix
		#../includes/development.nix
		#../includes/education.nix
		../includes/firewall.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Networking
	networking.hostName = "cornwall-tv"; # Define your hostname.
	networking.networkmanager.enable = true;

	# Enable the X11 windowing system.
	# You can disable this if you're only using the Wayland session.
	services.xserver.enable = true;
	services.xserver.excludePackages = [pkgs.xterm];
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};
	

	
	services.pipewire.extraConfig.pipewire."91-null-sinks" = {
		
		"context.objects" = [
			{
				factory = "adapter";
				args = {
					"factory.name"     = "support.null-audio-sink";
					"node.name"        = "Virtual-Sink";
					"node.description" = "Virtual Sink";
					"media.class"      = "Audio/Sink";
					"audio.position"   = "FL FR FC LFE RL RR";
					"monitor.channel-volumes" = true;
				};
			}
			
			
			#{
			#	# A default dummy driver. This handles nodes marked with the "node.always-driver"
			#	# properyty when no other driver is currently active. JACK clients need this.
			#	factory = "spa-node-factory";
			#	args = {
			#	"factory.name"     = "support.node.driver";
			#	"node.name"        = "Dummy-Driver";
			#	"priority.driver"  = 8000;
			#	};
			#}
			#{
			#	factory = "adapter";
			#	args = {
			#	"factory.name"     = "support.null-audio-sink";
			#	"node.name"        = "Microphone-Proxy";
			#	"node.description" = "Microphone";
			#	"media.class"      = "Audio/Source/Virtual";
			#	"audio.position"   = "MONO";
			#	};
			#}
			#{
			#	factory = "adapter";
			#	args = {
			#	"factory.name"     = "support.null-audio-sink";
			#	"node.name"        = "Main-Output-Proxy";
			#	"node.description" = "Main Output";
			#	"media.class"      = "Audio/Sink";
			#	"audio.position"   = "FL,FR";
			#	};
			#}
		];
	};
	
	
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

