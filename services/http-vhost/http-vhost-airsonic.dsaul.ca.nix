
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../http-acme/certificate-dsaul.ca.nix
	];
	
	services.nginx = {
		
		virtualHosts."airsonic.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				proxyPass = "http://10.5.5.5:4040";
				proxyWebsockets = true; # needed if you need to use WebSocket
				
				extraConfig = ''
					proxy_ssl_server_name on;
				'';
			};
			
			
		};
	};
	
	
}
