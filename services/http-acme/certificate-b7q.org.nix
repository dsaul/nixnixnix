{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."hetzner-dns.age".file = ../../secrets/hetzner-dns.age;
	
	security.acme.certs."b7q.org" = {
		domain = "b7q.org";
		extraDomainNames = [ "*.b7q.org" ];
		group = config.services.nginx.group;
		
		# The LEGO DNS provider name. Depending on the provider, need different
		# contents in the credentialsFile below.
		dnsProvider = "hetzner";
		dnsPropagationCheck = true;
		credentialsFile = config.age.secrets."hetzner-dns.age".path;
	};
	
	# systemctl status acme-b7q.org.service
	# journalctl -u  acme-b7q.org.service --since today --follow
}
