{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."hetzner-dns.age".file = ../../secrets/hetzner-dns.age;
	
	security.acme.certs."epsilonlabs.ca" = {
		domain = "epsilonlabs.ca";
		extraDomainNames = [ "*.epsilonlabs.ca" ];
		group = config.services.nginx.group;
		
		# The LEGO DNS provider name. Depending on the provider, need different
		# contents in the credentialsFile below.
		dnsProvider = "hetzner";
		dnsPropagationCheck = true;
		credentialsFile = config.age.secrets."hetzner-dns.age".path;
	};
	
	# systemctl status acme-dsaul.ca.service
	# journalctl -u  acme-dsaul.ca.service --since today --follow
}
