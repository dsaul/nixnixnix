
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
				deviceUri = "ipp://10.5.5.14/";
				model = "everywhere";
			}
		];
		ensureDefaultPrinter = "Cornwall_Brother_MFCL8900CDW";
	};
}
