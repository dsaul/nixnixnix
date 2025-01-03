
{ config, lib, pkgs, modulesPath, ... }:
{
	imports = [
		./hardware-printers-generic.nix
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
