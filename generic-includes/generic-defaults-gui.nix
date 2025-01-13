{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../services/services-samba.nix
	];
	
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
		
		(pkgs.callPackage ../packages/webapp-davis/package.nix {})
		(pkgs.callPackage ../packages/webapp-home-assistant/package.nix {})
		(pkgs.callPackage ../packages/webapp-immich/package.nix {})
		(pkgs.callPackage ../packages/webapp-mealie/package.nix {})
		(pkgs.callPackage ../packages/webapp-pgadmin4/package.nix {})
	];
}
	


