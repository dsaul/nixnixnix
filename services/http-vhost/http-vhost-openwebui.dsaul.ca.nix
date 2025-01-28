
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../http-acme/certificate-dsaul.ca.nix
	];
	
	services.nginx = {
		
		virtualHosts."openwebui.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				proxyPass = "http://10.5.5.20:25365";
				proxyWebsockets = true; # needed if you need to use WebSocket
				
				extraConfig = ''
					client_max_body_size 200M;
					proxy_ssl_server_name on;
					allow 10.5.5.0/24; # cornwall lan
					allow 172.16.0.0/24; # vpn
					allow 10.3.3.2/32; # Lindsey's phone on public wifi
					deny all;
				'';
			};
			
			
		};
	};
	
	
}
