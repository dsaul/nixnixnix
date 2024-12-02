{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	# Enable the X11 windowing system.
	# You can disable this if you're only using the Wayland session.
	services.xserver.enable = true;
	services.xserver.excludePackages = [pkgs.xterm];
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	xdg.portal.enable = true;
	xdg.portal.xdgOpenUsePortal = true;
	services.tumbler.enable = true;

	# Enable the KDE Plasma Desktop Environment.
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	#programs.kdeconnect.enable = true;
	
	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		
	];

	environment.systemPackages = with pkgs; [
		kdePackages.yakuake
		kdePackages.xdg-desktop-portal-kde
		xdg-desktop-portal	
		xfce.thunar # sshfs works best with this
		qalculate-qt # a better calculator
	];

	environment.sessionVariables = rec {
			ELECTRON_OZONE_PLATFORM_HINT  = "wayland";
			GSK_RENDERER = "gl";
	};

}
