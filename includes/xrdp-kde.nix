
{ config, lib, pkgs, modulesPath, ... }:

{
	services.xrdp.enable = true;
	services.xrdp.defaultWindowManager = "startplasma-x11";
	services.xrdp.openFirewall = true;
}

