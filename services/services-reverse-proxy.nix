
{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."hetzner-dns.age".file = ../secrets/hetzner-dns.age;
	
	security.acme.acceptTerms = true;
	security.acme.defaults.email = "dan@dsaul.ca";
	
	# systemctl status acme-dsaul.ca.service
	# journalctl -u  acme-dsaul.ca.service --since today --follow
	security.acme.certs."dsaul.ca" = {
		domain = "dsaul.ca";
		extraDomainNames = [ "*.dsaul.ca" ];
		group = config.services.nginx.group;
		
		# The LEGO DNS provider name. Depending on the provider, need different
		# contents in the credentialsFile below.
		dnsProvider = "hetzner";
		dnsPropagationCheck = true;
		credentialsFile = config.age.secrets."hetzner-dns.age".path;
	};
	
	networking.firewall.allowedTCPPorts = [ 80 443 ];
	
	services.nginx = {
		enable = true;
		recommendedProxySettings = true;
		recommendedTlsSettings = true;
		recommendedGzipSettings = true;
		recommendedOptimisation = true;
		
	};
	
	
}
