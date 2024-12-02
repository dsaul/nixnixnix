
{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	services.xrdp.enable = true;
	services.xrdp.defaultWindowManager = "startplasma-x11";
	services.xrdp.openFirewall = true;
}

