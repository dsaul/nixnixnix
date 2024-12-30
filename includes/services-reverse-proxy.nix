
{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."hetzner-dns.age".file = ../secrets/hetzner-dns.age;
	
	security.acme.acceptTerms = true;
	security.acme.defaults.email = "dan@dsaul.ca";
	security.acme.defaults.dnsPropagationCheck = false;
	security.acme.defaults.extraLegoRunFlags = [
		"--dns.propagation-rns=true"
		"--dns.propagation-disable-ans"
	];
	
	# systemctl status acme-dsaul.ca.service
	# journalctl -u  acme-dsaul.ca.service --since today --follow
	security.acme.certs."dsaul.ca" = {
		domain = "dsaul.ca";
		extraDomainNames = [ "www.dsaul.ca" ];
		
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
		
		#virtualHosts."calendar.dsaul.ca" =  {
		#	enableACME = true;
		#	forceSSL = true;
			
		#	locations."/" = {
		#		proxyPass = "http://10.5.5.10:9900";
		#		proxyWebsockets = true; # needed if you need to use WebSocket
				
		#		extraConfig = ''
		#			proxy_ssl_server_name on;
		#			rewrite ^/.well-known/carddav /dav/ redirect;
		#			rewrite ^/.well-known/caldav /dav/ redirect;
		#		'';
					# required when the target is also TLS server with multiple hosts
					#"" #+
					# required when the server wants to use HTTP Authentication
					#"proxy_pass_header Authorization;"
				#;
		#	};
			
		#	extraConfig = ''
			
		#	'';
			
			
		#};
	};
	
	
}
