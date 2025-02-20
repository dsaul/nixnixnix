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
		python312Packages.pythonnet
		
		dotnet-sdk
		dotnet-runtime
		
		# Webview Service apps
		(pkgs.callPackage ../packages/webapp-jupyter/package.nix {})
	];
	
	environment.sessionVariables = {
		DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
	};
	
	services.ollama = {
		enable = true;
		loadModels = [
			"codellama:13b"
			"deepseek-r1:14b"
			"deepseek-coder-v2:latest"
			"mistral"
		];
	};
	services.open-webui = {
		enable = true;
		port = 25365;
		openFirewall = true;
		host = "0.0.0.0";
	};
}


	


