
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
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.kernelParams = ["nvidia-drm.modeset=1"];

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

	# MDNS
	services.avahi = { # So we can discover our printer.
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

	# Docker
	virtualisation.docker.enable = true;
	virtualisation.docker.package = pkgs.docker_25;
	virtualisation.docker.liveRestore = false;

	# Libvirt
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;
	virtualisation.libvirtd.qemu = {
		swtpm.enable = true;
		ovmf.packages = [ pkgs.OVMFFull.fd ];
	};

	time.timeZone = "America/Winnipeg";
	services.automatic-timezoned.enable = true;
	i18n.defaultLocale = "en_CA.UTF-8";

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

	# RDP
	services.xrdp.enable = true;
	services.xrdp.defaultWindowManager = "startplasma-x11";
	services.xrdp.openFirewall = true;


	# Printing
	services.printing.enable = true;
	systemd.services.cups-browsed.enable = false;
	services.printing.drivers = [
		pkgs.gutenprint
		pkgs.gutenprintBin
		pkgs.brgenml1lpr
		pkgs.brgenml1cupswrapper
		pkgs.brlaser
		pkgs.mfcl3770cdwlpr
		pkgs.mfcl8690cdwcupswrapper
		(pkgs.callPackage ./mfcl8900cdw.nix {}) # At some point if we need the exact driver, get this to work.
	];
	services.printing.logLevel = "debug";
	hardware.printers = {
		ensurePrinters = [
			#https://discourse.nixos.org/t/declarative-printer-setup-missing-driver/33777/6
			{
				name = "Brother_MFCL8900CDW";
				location = "Cornwall";
				deviceUri = "ipp://10.5.5.14";
				#model = "brother_mfcl8900cdw_printer_en.ppd"; # Brother Provided, Broken
				model = "brother_mfcl8690cdw_printer_en.ppd";
				ppdOptions = {
					PageSize = "Letter";
					Duplex = "DuplexNoTumble";
					Resolution = "600dpi";
					PrintQuality = "4";
					PwgRasterDocumentType = "Rgb_8";
				};
			}
		];
		ensureDefaultPrinter = "Brother_MFCL8900CDW";
	};

	#SMB
	services.samba = {
 		enable = true;
 		securityType = "user";
		openFirewall = true;
		shares = {
			homes = {
				browseable = "no";  # note: each home will be browseable; the "homes" share will not.
				"read only" = "no";
				"guest ok" = "no";
			};
		};
	};


	# SSHD
	services.openssh = {
		enable = true;
		settings.PasswordAuthentication = false;
		settings.KbdInteractiveAuthentication = false;
		settings.PermitRootLogin = "yes";
	};
	programs.ssh.startAgent = true;

	# Enable sound
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Hardware
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;



	# Load nvidia driver for Xorg and Wayland
	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {

		# Modesetting is required.
		modesetting.enable = true;

		# Nvidia power management. Experimental, and can cause sleep/suspend to fail.
		# Enable this if you have graphical corruption issues or application crashes after waking
		# up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
		# of just the bare essentials.
		powerManagement.enable = true; # required on 4090

		# Fine-grained power management. Turns off GPU when not in use.
		# Experimental and only works on modern Nvidia GPUs (Turing or newer).
		powerManagement.finegrained = false;

		# Use the NVidia open source kernel module (not to be confused with the
		# independent third-party "nouveau" open source driver).
		# Support is limited to the Turing and later architectures. Full list of
		# supported GPUs is at:
		# https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
		# Only available from driver 515.43.04+
		# Currently alpha-quality/buggy, so false is currently the recommended setting.
		open = false;

		# Enable the Nvidia settings menu,
		# accessible via `nvidia-settings`.
		nvidiaSettings = true;

		# Optionally, you may need to select the appropriate driver version for your specific GPU.
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
	hardware.nvidia-container-toolkit.enable = true;

	# Groups
	users.groups.media = {
		gid=990;
	};

	# Users
	users.users.dan = {
		uid=1000;
		isNormalUser = true;
		description = "Dan Saul";
		extraGroups = [
			"networkmanager"
			"wheel"
			"docker"
			"libvirtd"
			"media"
		];
		packages = with pkgs; [

		];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd dan@dsaul.ca"
		];
	};

	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd dan@dsaul.ca"
	];

	environment.sessionVariables = rec {
		ELECTRON_OZONE_PLATFORM_HINT  = "wayland";
		GSK_RENDERER = "gl";
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Required for Steam
	hardware.opengl = {
		enable = true; # Enable OpenGL required for nvidia
		driSupport = true;
		driSupport32Bit = true;
		extraPackages = with pkgs; [
			libGL
		];
		setLdLibraryPath = true;
	};


	# Installed Packages
	nixpkgs.config.permittedInsecurePackages = [  "olm-3.2.16" ];
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

		# Media
		par2cmdline-turbo
		kid3-qt
		vlc
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
		xdg-desktop-portal-kde
		xdg-desktop-portal

		# Communication
		discord
		element-desktop
		zoom-us
		thunderbird

		# Audio
		unstable.audacity
		wireplumber

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
		python312
		python312Packages.pip
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
		python311
		python311Packages.torch-bin
		python311Packages.unidecode
		python311Packages.inflect
		python311Packages.librosa
		python311Packages.pip

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
		};
	};
	programs.mtr.enable = true;
	programs.nix-ld.enable = true;
	services.tumbler.enable = true;

	fonts.enableDefaultPackages = true;
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk
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
