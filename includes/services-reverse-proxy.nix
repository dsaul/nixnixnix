
{ config, lib, pkgs, modulesPath, ... }:

{
	security.acme.acceptTerms = true;
	security.acme.defaults.email = "dan@dsaul.ca";
	
	security.acme.certs."dsaul.ca" = {
		domain = "dsaul.ca";
		extraDomainNames = [ "www.dsaul.ca" ];
		
		# The LEGO DNS provider name. Depending on the provider, need different
		# contents in the credentialsFile below.
		dnsProvider = "hetzner";
		dnsPropagationCheck = true;
		# agenix will decrypt our secrets file (below) on the server and make it available
		# under /run/agenix/secrets/hetzner-dns-token (by default):
		# credentialsFile = "/run/agenix/secrets/hetzner-dns-token";
		credentialsFile = config.age.secrets."hetzner-dns-token.age".path;
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
