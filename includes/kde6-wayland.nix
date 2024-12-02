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

	# Enable the KDE Plasma Desktop Environment.
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	#programs.kdeconnect.enable = true;
	
	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		
	];		
}
