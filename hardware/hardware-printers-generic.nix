
{ config, lib, pkgs, modulesPath, ... }:
{
	imports = [
		../services/services-mdns.nix
	];
	
	#journalctl --follow --unit=cups
	#journalctl --follow --unit=cups | grep -C10 --color=always -i -e 'No such file or directory' -e 'error:'
	#http://localhost:631/printers/

	# Printing
	services.printing.enable = true;
	systemd.services.cups-browsed.enable = false; # Disabled due to security issues.
	
	environment.systemPackages = with pkgs; [
		cups-filters
	];
	
}
