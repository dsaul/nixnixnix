
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../http-acme/certificate-dsaul.ca.nix
	];
	
	services.nginx = {
		virtualHosts."dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			globalRedirect = "www.dsaul.ca";
		};
		
		virtualHosts."www.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				#proxyPass = "http://10.5.5.5:9974";
				#proxyWebsockets = true; # needed if you need to use WebSocket
				#root = "/var/www/blog";
				
				
				return = "200 '<html><body>dsaul.ca</body></html>'";
				
				extraConfig = ''
					default_type text/html;
					proxy_ssl_server_name on;
				'';
			};
			
			
		};
	};
	
	
}
