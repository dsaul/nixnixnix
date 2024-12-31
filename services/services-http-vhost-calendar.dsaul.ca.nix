
{ config, lib, pkgs, modulesPath, ... }:

{
	
	services.nginx = {
		
		virtualHosts."calendar.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				proxyPass = "http://10.5.5.10:9900";
				proxyWebsockets = true; # needed if you need to use WebSocket
				
				extraConfig = ''
					proxy_ssl_server_name on;
					rewrite ^/.well-known/carddav /dav/ redirect;
					rewrite ^/.well-known/caldav /dav/ redirect;
					
					allow 10.5.5.0/24; # cornwall lan
					allow 172.16.0.0/24; # vpn
					allow 10.3.3.2/32; # Lindsey's phone on public wifi
					deny all;
				'';
			};
			
			
		};
	};
	
	
}
