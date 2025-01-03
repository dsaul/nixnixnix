

{ config, lib, pkgs, modulesPath, ... }:

{
	# Remember seafile on nixos stores its data in a system wide mysql, REMEMBER TO DUMP THIS.
	# mysqldump -u root -p --all-databases > alldb.sql
	
	imports = [
		./http-vhost/http-vhost-seafile.dsaul.ca.nix
	];
	
	config.services.seafile = {
		enable = true;
		dataDir = "/mnt/DOCUMENTS-01/stacks/seafile-data";
		adminEmail = "dan@dsaul.ca";
		initialAdminPassword = "change this later!";

		ccnetSettings.General.SERVICE_URL = "https://seafile.dsaul.ca";
		# Enable weekly collection of freed blocks
		gc = {
			enable = true;
			dates = [ "Sun 03:00:00" ];
		};
		
		seafileSettings = {
			history.keep_days = "14"; # Remove deleted files after 14 days
			
			fileserver = {
				host = "unix:/run/seafile/server.sock";
				web_token_expire_time = 18000; # Expire the token in 5h to allow longer uploads
			};
			
			
		};
	};
	
	config.system.activationScripts.ensureSeafileDirs = lib.stringAfter [ "var" ] ''
		mkdir -p /mnt/DOCUMENTS-01/stacks/seafile-data
		chown -R seafile:seafile /mnt/DOCUMENTS-01/stacks/seafile-data
	'';

	#networking.firewall.allowedTCPPorts = [ 8443 ];
	
	
}
