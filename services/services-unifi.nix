
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		./http-vhost/http-vhost-unifi.dsaul.ca.nix
	];
	services.unifi = {
		enable = true;
		openFirewall = true;
		#	unifiPackage
		mongodbPackage = pkgs.mongodb-6_0;
	};
	
	networking.firewall.allowedTCPPorts = [ 8443 ];
	
	
}
