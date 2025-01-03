
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		../services-acme.nix
		../http-acme/certificate-dsaul.ca.nix
	];
	
	services.nginx = {
		enable = true;
		recommendedProxySettings = true;
		recommendedTlsSettings = true;
		recommendedGzipSettings = true;
		recommendedOptimisation = true;
		
		# A default site so that it doesn't give the alphabetically first site for unknown hostnames.
		virtualHosts."_" = {
			forceSSL = true;
			useACMEHost = "dsaul.ca";
			
			default = true;
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
