
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		./http-vhost/http-vhost-unifi.dsaul.ca.nix
	];
	
	services.unifi.enable = true;
	services.unifi.openFirewall = true;
	networking.firewall.allowedTCPPorts = [ 8443 ];
	
	
}
