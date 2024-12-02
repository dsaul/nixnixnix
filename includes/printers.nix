
{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	# Printing
	services.printing.enable = true;
	systemd.services.cups-browsed.enable = false;
	services.printing.drivers = [
		pkgs.gutenprint
		pkgs.gutenprintBin
		pkgs.brgenml1lpr
		pkgs.brgenml1cupswrapper
		pkgs.brlaser
		pkgs.mfcl3770cdwlpr
		pkgs.mfcl8690cdwcupswrapper
		(pkgs.callPackage ./mfcl8900cdw.nix {}) # At some point if we need the exact driver, get this to work.
	];
	services.printing.logLevel = "debug";
	hardware.printers = {
		ensurePrinters = [
			#https://discourse.nixos.org/t/declarative-printer-setup-missing-driver/33777/6
			{
				name = "Brother_MFCL8900CDW";
				location = "Cornwall";
				deviceUri = "ipp://10.5.5.14";
				#model = "brother_mfcl8900cdw_printer_en.ppd"; # Brother Provided, Broken
				model = "brother_mfcl8690cdw_printer_en.ppd";
				ppdOptions = {
					PageSize = "Letter";
					Duplex = "DuplexNoTumble";
					Resolution = "600dpi";
					PrintQuality = "4";
					PwgRasterDocumentType = "Rgb_8";
				};
			}
		];
		ensureDefaultPrinter = "Brother_MFCL8900CDW";
	};
}
