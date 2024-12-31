{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		# Development Tools
		dbeaver-bin
		bruno
		umlet
		
		# Development Backend
		vscode
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
	];
}
	


