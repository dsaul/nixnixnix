
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		./http-vhost/http-vhost-unifi.dsaul.ca.nix
	];
	
	services.unifi.enable = true;
	services.unifi.openFirewall = true;
	services.unifi.unifiPackage = pkgs.unifi8;
	services.unifi.mongodbPackage = mongodb-7_0;
	networking.firewall.allowedTCPPorts = [ 8443 ];
	
	
}
