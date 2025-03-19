
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../http-acme/certificate-dsaul.ca.nix
	];
	
	services.nginx = {
		
		virtualHosts."twilml.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				#proxyPass = "http://10.5.5.5:9974";
				#proxyWebsockets = true; # needed if you need to use WebSocket
				#root = "/var/www/blog";
				
				
				return = "200 '<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Dial answerOnBridge=\"true\">+12049630285</Dial></Response>'";
				
				extraConfig = ''
					default_type text/html;
					proxy_ssl_server_name on;
				'';
			};
			
			
		};
	};
	
	
}
