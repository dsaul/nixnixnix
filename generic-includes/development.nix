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
		python312Packages.requests
		python312Packages.pytest
		python312Packages.black
		python312Packages.flake8
		
		# Webview Service apps
		(pkgs.callPackage ../packages/webapp-jupyter/package.nix {})
	];
	
	services.ollama = {
		enable = true;
	};
	services.open-webui = {
		enable = true;
		port = "25365";
	};
}


	


