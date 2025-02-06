
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../http-acme/certificate-epsilonlabs.ca.nix
	];
	
	services.nginx = {
		
		virtualHosts."www.epsilonlabs.ca" = {
			forceSSL = true;
			useACMEHost = "epsilonlabs.ca";
			
			locations."/" = {
				#proxyPass = "http://10.5.5.5:9974";
				#proxyWebsockets = true; # needed if you need to use WebSocket
				#root = "/var/www/blog";
				
				
				return = "200 '<html><body>epsilonlabs.ca</body></html>'";
				
				extraConfig = ''
					default_type text/html;
					proxy_ssl_server_name on;
				'';
			};
			
			
		};
	};
	
	
}
