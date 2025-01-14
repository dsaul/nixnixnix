{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../system/system-docker.nix
		../system/system-virtualisation.nix
	];
	
	environment.systemPackages = with pkgs; [
		# Development Tools
		dbeaver-bin
		bruno
		umlet
		httpie
		vscode.fhs
		
		# Development Backend
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
		libicns
		jdk
		
		# Webview Service apps
		(pkgs.callPackage ../packages/webapp-jupyter/package.nix {})
	];
}
	


