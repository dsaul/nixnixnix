{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."hetzner-dns.age".file = ../../secrets/hetzner-dns.age;
	
	security.acme.certs."lindseychilds.ca" = {
		domain = "lindseychilds.ca";
		extraDomainNames = [ "*.lindseychilds.ca" ];
		group = config.services.nginx.group;
		
		# The LEGO DNS provider name. Depending on the provider, need different
		# contents in the credentialsFile below.
		dnsProvider = "hetzner";
		dnsPropagationCheck = true;
		credentialsFile = config.age.secrets."hetzner-dns.age".path;
	};
	
	# systemctl status acme-lindseychilds.ca.service
	# journalctl -u  acme-lindseychilds.ca.service --since today --follow
}
