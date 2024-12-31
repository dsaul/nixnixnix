{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."hetzner-dns.age".file = ../../secrets/hetzner-dns.age;
	
	security.acme.certs."cryingwolf.org" = {
		domain = "cryingwolf.org";
		extraDomainNames = [ "*.cryingwolf.org" ];
		group = config.services.nginx.group;
		
		# The LEGO DNS provider name. Depending on the provider, need different
		# contents in the credentialsFile below.
		dnsProvider = "hetzner";
		dnsPropagationCheck = true;
		credentialsFile = config.age.secrets."hetzner-dns.age".path;
	};
	
	# systemctl status acme-cryingwolf.org.service
	# journalctl -u  acme-cryingwolf.org.service --since today --follow
}
