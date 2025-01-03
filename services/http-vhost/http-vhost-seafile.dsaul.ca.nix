
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../http-acme/certificate-dsaul.ca.nix
	];
	
	config.services.nginx = {
		
		virtualHosts."seafile.dsaul.ca" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			locations."/" = {
				proxyPass = "http://unix:/run/seahub/gunicorn.sock";
				proxyWebsockets = true; # needed if you need to use WebSocket
				
				extraConfig = ''
					proxy_ssl_server_name on;
					allow 10.5.5.0/24; # cornwall lan
					allow 172.16.0.0/24; # vpn
					allow 10.3.3.2/32; # Lindsey's phone on public wifi
					deny all;
					
					proxy_read_timeout  1200s;
					client_max_body_size 0;
				'';
			};
			
			locations."/seafhttp" = {
				proxyPass = "http://unix:/run/seafile/server.sock";
				extraConfig = ''
					proxy_ssl_server_name on;
					allow 10.5.5.0/24; # cornwall lan
					allow 172.16.0.0/24; # vpn
					allow 10.3.3.2/32; # Lindsey's phone on public wifi
					deny all;
					
					rewrite ^/seafhttp(.*)$ $1 break;
					client_max_body_size 0;
					proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
					proxy_connect_timeout  36000s;
					proxy_read_timeout  36000s;
					proxy_send_timeout  36000s;
					send_timeout  36000s;
				'';
			};
		};
	};
	
	
}
