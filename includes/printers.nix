
{ config, lib, pkgs, modulesPath, ... }:
{
	#journalctl --follow --unit=cups
	#journalctl --follow --unit=cups | grep -C10 --color=always -i -e 'No such file or directory' -e 'error:'
	#http://localhost:631/printers/

	# Printing
	services.printing.enable = true;
	systemd.services.cups-browsed.enable = false; # Disabled due to security issues.
	
	environment.systemPackages = with pkgs; [
		cups-filters
	];
	
	hardware.printers = {
		ensurePrinters = [
			{
				name = "Cornwall_Brother_MFCL8900CDW";
				location = "Cornwall";
				deviceUri = "ipp://cornwall-printer.infra.dsaul.ca/";
				model = "everywhere";
			}
		];
		ensureDefaultPrinter = "Cornwall_Brother_MFCL8900CDW";
	};
}
