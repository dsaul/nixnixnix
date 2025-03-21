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
		dhex
		ghex
		plantuml
		
		
		
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
		#pylint
		jetbrains.goland
		jetbrains.writerside
		jetbrains.webstorm
		jetbrains.rust-rover
		jetbrains.rider
		jetbrains.pycharm-professional
		jetbrains.mps
		jetbrains.idea-ultimate
		jetbrains.datagrip
		jetbrains.clion
		
		(python312.withPackages (ps: with ps; [
			pandas
			numpy
			requests
			pytest
			black
			flake8
			pythonnet
			pylint
			pygments
		]))
		
		dotnet-sdk
		dotnet-runtime
		
		# Webview Service apps
		(pkgs.callPackage ../packages/webapp-jupyter/package.nix {})
	];
	
	environment.sessionVariables = {
		DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
	};
	
	
}


	


