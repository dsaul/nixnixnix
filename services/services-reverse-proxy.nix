
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		./services-acme.nix
	];
	
	services.nginx = {
		enable = true;
		recommendedProxySettings = true;
		recommendedTlsSettings = true;
		recommendedGzipSettings = true;
		recommendedOptimisation = true;
		
		virtualHosts."_" = {
			listen = [ { addr = "0.0.0.0"; port = 80; default = true; } ];
			locations."/" = {
				
				return = "200 '<html><body></body></html>'";
				extraConfig = ''
					default_type text/html;
				'';
			};
		};
	};
	
	networking.firewall.allowedTCPPorts = [ 80 443 ];
}
