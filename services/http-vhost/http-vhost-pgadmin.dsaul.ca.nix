
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../http-acme/certificate-dsaul.ca.nix
	];
	
	services.nginx = {
		
		virtualHosts."pgadmin.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				proxyPass = "http://10.5.5.5:25003";
				proxyWebsockets = true; # needed if you need to use WebSocket
				
				extraConfig = ''
					proxy_ssl_server_name on;
					
					allow 10.5.5.0/24; # cornwall lan
					allow 172.16.0.0/24; # vpn
					deny all;
				'';
			};
			
			
		};
	};
	
	
}
