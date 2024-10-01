# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
	programs.kdeconnect.enable = true;

	# RDP
	services.xrdp.enable = true;
	services.xrdp.defaultWindowManager = "startplasma-x11";
	services.xrdp.openFirewall = true;
	
	# Printing
	services.printing.enable = true;
	services.printing.drivers = [
		pkgs.brlaser
	];
	
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

	# Users
	users.users.dan = {
		isNormalUser = true;
		description = "Dan Saul";
		extraGroups = [
			"networkmanager"
			"wheel"
			"docker"
			"libvirtd"
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

	
	

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;


	# Required for Steam
	hardware.opengl.enable = true;
	hardware.opengl.driSupport = true;
	hardware.opengl.driSupport32Bit = true;


	# Installed Packages
	environment.systemPackages = with pkgs; [
		vim
		wget
		winbox
		obsidian
		mtr
		mtr-gui
		audacity
		dbeaver-bin
		discord
		element-desktop
		ffmpeg_7-full
		freecad
		git
		delfin
		keepassxc
		texliveFull
		sunshine
		moonlight-qt
		steam
		vscode
		vlc
		wireshark
		zoom-us
		kate
		thunderbird
		onlyoffice-bin
		libreoffice-qt6-fresh
		seafile-client
		texmaker
		wineWowPackages.waylandFull
		python3
		qemu
		quickemu
		virt-manager
		libvirt
		kdePackages.kcalc
	];
	programs.firefox.enable = true;

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
	];
	
	
	

	

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
