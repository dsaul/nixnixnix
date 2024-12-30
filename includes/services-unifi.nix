
{ config, lib, pkgs, modulesPath, ... }:

{
	services.unifi.enable = true;
	services.unifi.openFirewall = true;
	networking.firewall.allowedTCPPorts = [ 8443 ];
}
