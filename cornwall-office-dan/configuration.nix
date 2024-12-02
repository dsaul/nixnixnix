 
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
#sudo nix-channel --update nixos-unstable


{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in 
{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./includes/locale.nix
		./includes/virtualisation.nix
		./includes/printers.nix
		./includes/cifs.nix
		./includes/sshd.nix
		./includes/sound.nix
		./includes/xrdp-kde.nix
		./includes/bluetooth.nix
		./includes/nvidia.nix
		./includes/usersandgroups.nix
		./includes/mdns.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	# Enable support for directly running app images.
	programs.appimage.enable = true;
	programs.appimage.binfmt = true;

	# Networking
	networking.hostName = "cornwall-office-dan"; # Define your hostname.
	networking.networkmanager.enable = true;
	networking.extraHosts = 
		''

		0.0.0.0 news.ycombinator.com
		0.0.0.0 linkedin.com
		0.0.0.0 www.linkedin.com
		'';
		
		#		0.0.0.0 www.youtube.com
	#	0.0.0.0 youtube.com

	# Enable the X11 windowing system.
	# You can disable this if you're only using the Wayland session.
	services.xserver.enable = true;
	services.xserver.excludePackages = [pkgs.xterm];
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable the KDE Plasma Desktop Environment.
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	#programs.kdeconnect.enable = true;
	
	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		
	];

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	environment.sessionVariables = rec {
		ELECTRON_OZONE_PLATFORM_HINT  = "wayland";
		GSK_RENDERER = "gl";
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Required for Steam
	hardware.graphics = {
		enable = true;
		extraPackages = with pkgs; [
                        libGL
                ];
		enable32Bit = true;
	};


	# Installed Packages
	environment.systemPackages = with pkgs; [
		# Expected commands
		dig
		usbutils
		pciutils
		xfsprogs
		wget
		mtr-gui
		bc
		curl
		htop
		procps
		util-linux
		unzip
		psmisc
		nvtopPackages.full

		# Filesystems
		ntfs3g
		gparted
		cifs-utils
		
		#waydroid
		wl-clipboard

		# Media
		par2cmdline-turbo
		kid3-qt
		vlc
		mplayer
		ffmpeg_7-full
		yt-dlp
		spotify
		mkvtoolnix
		metamorphose2
		handbrake
		calibre
		#unstable.jellyfin-media-player
		flac

		# Network
		transmission_4-qt
		#winbox
		unstable.winbox4
		remmina
		wireshark
		seafile-client
		freerdp
		freerdp3
		ungoogled-chromium
		wireguard-tools

		# Editors
		gedit
		obsidian
		vim
		kate
		#onlyoffice-bin
		unstable.onlyoffice-desktopeditors
		libreoffice-qt6-fresh
		texmaker
		texliveFull
		perlPackages.YAMLTiny #latexindent
		perlPackages.FileHomeDir #latexindent
		perlPackages.UnicodeLineBreak #latexindent
		ocrmypdf
		# dia # Broken
	
		# KDE
		kdePackages.yakuake
		kdePackages.xdg-desktop-portal-kde
		xdg-desktop-portal

		# Communication
		#discord
		#(discord.override {
		#	# withOpenASAR = true; # can do this here too
		#	withVencord = true;
		#})
		vesktop
		jami
		
		element-desktop
		zoom-us
		thunderbird

		# Audio
		unstable.audacity
		wireplumber
		qpwgraph
		unstable.sonusmix
		
		# Graphics
		gimp
		krita #doesn't work on 4090
		inkscape
		librsvg
	
		# Development Tools
		dbeaver-bin
		bruno
		#unstable.kdePackages.umbrello
		umlet
		
		
		# Development Backend
		git
		vscode
		#python312
		#python312Packages.pip
		libgcc
		cargo
		gitRepo
		gnupg
		autoconf
		gnumake
		m4
		gperf
		cudatoolkit
		ncurses5
		stdenv.cc
		binutils
		nodejs
		go
		#python311
		#python311Packages.torch-bin
		#python311Packages.unidecode
		#python311Packages.inflect
		#python311Packages.librosa
		#python311Packages.pip

		# Security
		unstable.freecad-wayland
		keepassxc

		# Games
		steam
		sunshine
		moonlight-qt
		ryujinx

		# Virtualization
		qemu
		quickemu
		virt-manager
		libvirt

		# Education
		anki
		qalculate-qt

		#feishin
		#nheko
		#unstable.delfin
		
		# NVIDIA
		#nvidia-container-toolkit
		
		basiliskii
		krusader
		xfce.thunar
		
		(pkgs.wrapOBS {
			plugins = with pkgs.obs-studio-plugins; [
				wlrobs
				obs-backgroundremoval
				obs-pipewire-audio-capture
			];
		})
	];

	programs.firefox = {
		enable = true;
		preferences = {
			"widget.use-xdg-desktop-portal.file-picker" = 1;
			"PULSE_LATENCY_MSEC" = "60";
		};
	};
	programs.mtr.enable = true;
	programs.nix-ld.enable = true;
	services.tumbler.enable = true;

	xdg.portal.enable = true;
	xdg.portal.xdgOpenUsePortal = true;
	
	fonts.enableDefaultPackages = true;
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-emoji
		liberation_ttf
		fira-code
		fira-code-symbols
		mplus-outline-fonts.githubRelease
		dina-font
		proggyfonts
		atkinson-hyperlegible
	];



	# Filesystems
	services.gvfs.enable = true;

	# For mount.cifs, required unless domain name resolution is not needed.
	fileSystems."/mnt/MISC-01" = {
		device = "//10.5.5.10/MISC-01";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/DOCUMENTS-01" = {
		device = "//10.5.5.10/DOCUMENTS-01";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};

	fileSystems."/mnt/MEDIA-01" = {
		device = "//10.5.5.10/MEDIA-01";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-02" = {
		device = "//10.5.5.10/MEDIA-02";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-03" = {
		device = "//10.5.5.10/MEDIA-03";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-04" = {
		device = "//10.5.5.10/MEDIA-04";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-05" = {
		device = "//10.5.5.10/MEDIA-05";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-06" = {
		device = "//10.5.5.10/MEDIA-06";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-07" = {
		device = "//10.5.5.10/MEDIA-07";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-08" = {
		device = "//10.5.5.10/MEDIA-08";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-09" = {
		device = "//10.5.5.10/MEDIA-09";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-10" = {
		device = "//10.5.5.10/MEDIA-10";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-11" = {
		device = "//10.5.5.10/MEDIA-11";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-12" = {
		device = "//10.5.5.10/MEDIA-12";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-13" = {
		device = "//10.5.5.10/MEDIA-13";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-14" = {
		device = "//10.5.5.10/MEDIA-14";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-15" = {
		device = "//10.5.5.10/MEDIA-15";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-16" = {
		device = "//10.5.5.10/MEDIA-16";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-17" = {
		device = "//10.5.5.10/MEDIA-17";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};
	fileSystems."/mnt/MEDIA-18" = {
		device = "//10.5.5.10/MEDIA-18";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};

	fileSystems."/mnt/FS" = {
		device = "//10.5.5.15/FS";
		fsType = "cifs";
		options = let
		# this line prevents hanging on network split
		automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
		in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.dan.uid},gid=${toString config.users.groups.media.gid}"];
	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

	system.stateVersion = "24.05"; # Did you read the comment?

}

