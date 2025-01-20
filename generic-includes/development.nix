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
		pylint
		python312Full
		python312Packages.pandas
		
		#(pkgs.python312Full.withPackages (python-pkgs: with python-pkgs; [
			# select Python packages here
		#	pandas
		#	requests
		#	pytest
		#	black
		#	flake8
		#]))
		
		# Webview Service apps
		(pkgs.callPackage ../packages/webapp-jupyter/package.nix {})
	];
}
	


