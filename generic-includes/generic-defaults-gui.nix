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
	];
}
	


