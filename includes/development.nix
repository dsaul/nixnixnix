{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	environment.systemPackages = with pkgs; [
		# Development Tools
		dbeaver-bin
		bruno
		#unstable.kdePackages.umbrello
		umlet
		
		
		# Development Backend
		git
		vscode
		#python312
		#python312Packages.pip
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
		#python311
		#python311Packages.torch-bin
		#python311Packages.unidecode
		#python311Packages.inflect
		#python311Packages.librosa
		#python311Packages.pip
	];
}
	


