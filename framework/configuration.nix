# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in
{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	nix.settings.experimental-features = ["nix-command" "flakes"];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Enable support for directly running app images.
	programs.appimage.enable = true;
	programs.appimage.binfmt = true;

	# Networking
	networking.hostName = "framework"; # Define your hostname.
	networking.networkmanager.enable = true;

	# Fingerprint Sensor
	# services.fprintd.enable = true; # currently broken, messes with initial login


	# MDNS
	services.avahi = { # So we can discover our printer.
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

	# Docker
	virtualisation.docker.enable = true;

	# Libvirt
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;
	virtualisation.libvirtd.qemu = {
		swtpm.enable = true;
		ovmf.packages = [ pkgs.OVMFFull.fd ];
	};

	# Region Settings
	time.timeZone = "America/Winnipeg";
	services.automatic-timezoned.enable = true;
	i18n.defaultLocale = "en_CA.UTF-8";

	# Enable the X11 windowing system.
	# You can disable this if you're only using the Wayland session.
	services.xserver.enable = true;
	services.xserver.excludePackages = [pkgs.xterm];
	services.xserver.xkb = { # Configure keymap in X11
		layout = "us";
		variant = "";
	};

	# Enable the KDE Plasma Desktop Environment.
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	#programs.kdeconnect.enable = true;

	# RDP
	services.xrdp.enable = true;
	services.xrdp.defaultWindowManager = "startplasma-x11";
	services.xrdp.openFirewall = true;

	# Printing
	services.printing.enable = true;
	services.printing.drivers = [
		pkgs.gutenprint
		pkgs.gutenprintBin
		pkgs.brgenml1lpr
		pkgs.brgenml1cupswrapper
		pkgs.brlaser
		pkgs.mfcl3770cdwlpr
		pkgs.mfcl8690cdwcupswrapper
	];
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

	# Sound
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
	};


	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;



	# Required for Steam
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
		jellyfin-media-player

		# Network
		transmission_4-qt
		winbox
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
		onlyoffice-bin
		libreoffice-qt6-fresh
		texmaker
		texliveFull
		perlPackages.YAMLTiny #latexindent
		perlPackages.FileHomeDir #latexindent
		perlPackages.UnicodeLineBreak #latexindent

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

		# Graphics
		gimp
		#krita #doesn't work on 4090

		# Development
		dbeaver-bin
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
		umlet

		# Security
		freecad
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
		jami
		fw-ectool
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

			# Disable mozilla injecting preferences.
			"app.normandy.api_url" = "";
			"app.normandy.enabled" = false;

			# No we don't want to be your guinea pigs.
			"app.shield.optoutstudies.enabled" = false;


			"app.update.auto" = false; # No auto updates.
			"beacon.enabled" = false; # Don't tell websites what you click on.
			"browser.send_pings" = false; # Don't tell websites what you click on.
			"breakpad.reportURL" = ""; # Don't send crash reports.
			"browser.crashReports.unsubmittedCheck.autoSubmit" = false; # Don't send crash reports.
			"browser.crashReports.unsubmittedCheck.autoSubmit2" = false; # Don't send crash reports.
			"browser.crashReports.unsubmittedCheck.enabled" = false; # Don't send crash reports.

			"browser.disableResetPrompt" = true; # don't prompt to reset after period of inactivity

			"browser.aboutConfig.showWarning" = false; # don't show danger warning on about:config
			"browser.fixup.alternate.enabled" = false; # don't have firefox attempt to change uris

			"browser.newtab.preload" = false; # disable preloading of pages on new tab
			"browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # fuck pocket
			"browser.newtabpage.enhanced" = false; # disable new tab ads
			"browser.newtabpage.introShown" = true;  # disable new tab ads

			# disable safebrowsing (send everything to google)
			"browser.safebrowsing.appRepURL" = "";
			"browser.safebrowsing.blockedURIs.enabled" = false;
			"browser.safebrowsing.downloads.enabled" = false;
			"browser.safebrowsing.downloads.remote.enabled" = false;
			"browser.safebrowsing.downloads.remote.url" = "";
			"browser.safebrowsing.enabled" = false;
			"browser.safebrowsing.malware.enabled" = false;
			"browser.safebrowsing.phishing.enabled" = false;


			"browser.search.suggest.enabled" = false; # disable sending typed form data to search provider

			"browser.selfsupport.url" = ""; # Disable metrics to mozilla.

			"browser.sessionstore.privacy_level" = 0; # Allow session restore to contain form fields.
			"browser.shell.checkDefaultBrowser" = true; # prompt if not default browser
			"browser.startup.homepage_override.mstone" = "ignore"; # no you don't change my homepage automatically, wtf
			"browser.tabs.crashReporting.sendReport" = false; # disable sending of crash reports
			"browser.urlbar.groupLabels.enabled" = false; # disable firefox suggest
			"browser.urlbar.quicksuggest.enabled" = false; # disable firefox suggest
			"browser.urlbar.speculativeConnect.enabled" = false; # don't connect unless we actually try to connect
			"browser.urlbar.trimURLs" = false; # don't hide part of the url bar, wtf

			# disable telemetry
			"toolkit.telemetry.archive.enabled" = false;
			"toolkit.telemetry.bhrPing.enabled" = false;
			"toolkit.telemetry.cachedClientID" = "";
			"toolkit.telemetry.enabled" = false;
			"toolkit.telemetry.firstShutdownPing.enabled" = false;
			"toolkit.telemetry.hybridContent.enabled" = false;
			"toolkit.telemetry.newProfilePing.enabled" = false;
			"toolkit.telemetry.prompted" = 2;
			"toolkit.telemetry.rejected" = true;
			"toolkit.telemetry.reportingpolicy.firstRun" = false;
			"toolkit.telemetry.server" = "";
			"toolkit.telemetry.shutdownPingSender.enabled" = false;
			"toolkit.telemetry.unified" = false;
			"toolkit.telemetry.unifiedIsOptIn" = false;
			"toolkit.telemetry.updatePing.enabled" = false;

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



	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
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
