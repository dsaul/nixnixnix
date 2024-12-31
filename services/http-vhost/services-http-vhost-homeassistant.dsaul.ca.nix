
{ config, lib, pkgs, modulesPath, ... }:

{
	
	services.nginx = {
		
		virtualHosts."homeassistant.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				proxyPass = "http://10.5.5.10:8123";
				proxyWebsockets = true; # needed if you need to use WebSocket
				
				extraConfig = ''
					proxy_ssl_server_name on;
					
				'';
			};
			
			
		};
	};
	
	
}
