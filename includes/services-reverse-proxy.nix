
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
		
		# The LEGO DNS provider name. Depending on the provider, need different
		# contents in the credentialsFile below.
		dnsProvider = "hetzner";
		dnsPropagationCheck = true;
		credentialsFile = config.age.secrets."hetzner-dns.age".path;
	};
	
	services.nginx = {
		enable = true;
		recommendedProxySettings = true;
		recommendedTlsSettings = true;
		recommendedGzipSettings = true;
		recommendedOptimisation = true;
		
		virtualHosts."calendar.dsaul.ca" = {
			#forceSSL = true;
			#useACMEHost = "dsaul.ca";
			
			#locations."/" = {
			#	proxyPass = "http://10.5.5.10:9900";
			#	proxyWebsockets = true; # needed if you need to use WebSocket
			#};
			
			
		};
	};
	
	
}
