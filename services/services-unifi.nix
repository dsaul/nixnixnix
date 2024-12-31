
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		./http-vhost/services-http-vhost-unifi.dsaul.ca.nix
	];
	
	services.unifi.enable = true;
	services.unifi.openFirewall = true;
	networking.firewall.allowedTCPPorts = [ 8443 ];
	
	
}
