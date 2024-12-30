
{ config, lib, pkgs, modulesPath, ... }:

{
	services.nginx = {
		enable = true;
		recommendedProxySettings = true;
		recommendedTlsSettings = true;
		recommendedGzipSettings = true;
		recommendedOptimisation = true;
		
		virtualHosts."calendar.dsaul.ca" =  {
			enableACME = true;
			forceSSL = true;
			
			locations."/" = {
				proxyPass = "http://10.5.5.10:9900";
				proxyWebsockets = true; # needed if you need to use WebSocket
				
				extraConfig = ''
					proxy_ssl_server_name on;
					rewrite ^/.well-known/carddav /dav/ redirect;
					rewrite ^/.well-known/caldav /dav/ redirect;
				'';
					# required when the target is also TLS server with multiple hosts
					#"" #+
					# required when the server wants to use HTTP Authentication
					#"proxy_pass_header Authorization;"
				#;
			};
			
			extraConfig = ''
			
			'';
			
			
		};
	};
	
	
}
