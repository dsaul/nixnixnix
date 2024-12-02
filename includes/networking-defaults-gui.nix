{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in 
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	programs.mtr.enable = true;	

	environment.systemPackages = with pkgs; [
		mtr-gui
		transmission_4-qt
		unstable.winbox4
		remmina
		wireshark
		seafile-client
		freerdp
		freerdp3
		ungoogled-chromium
	];

	programs.firefox = {
		enable = true;
		preferences = {
			"widget.use-xdg-desktop-portal.file-picker" = 1;
		};
	};


}
