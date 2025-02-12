{ config, lib, pkgs, modulesPath, ... }:
let
	unstable = import <nixos-unstable> { 
		system = "x86_64-linux"; 
		config.allowUnfree = true; 
		config.allowBroken = true; 
	};
in 
{
	imports = [
		../services/services-samba.nix
	];
	
	fonts.fontconfig.useEmbeddedBitmaps = true;
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
	
	environment.systemPackages = with pkgs; [
		keepassxc
		gparted
		via #keyboard
		vial #keyboard
		qmk
		qmk_hid
		qmk-udev-rules
		#unstable.ladybird
		
		(pkgs.callPackage ../packages/webapp-davis/package.nix {})
		(pkgs.callPackage ../packages/webapp-home-assistant/package.nix {})
		(pkgs.callPackage ../packages/webapp-immich/package.nix {})
		(pkgs.callPackage ../packages/webapp-mealie/package.nix {})
		(pkgs.callPackage ../packages/webapp-pgadmin4/package.nix {})
		(pkgs.callPackage ../packages/webapp-whishper/package.nix {})
		(pkgs.callPackage ../packages/webapp-paperless-ngx/package.nix {})
		
		
		adwaita-icon-theme
	];
	
	#programs.ladybird.enable = true;
	
	# reduce gnome errors
	programs.dconf.enable = true;
	#services.gnome3.tracker.enable = true;
	services.gnome.localsearch.enable = true;
}
	


