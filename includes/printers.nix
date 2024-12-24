
{ config, lib, pkgs, modulesPath, ... }:
let
	mfcl8900cdwlpr = (pkgs.callPackage ../mfcl8900cdwlpr/package.nix {});
	mfcl8900cdwcupswrapper = (pkgs.callPackage ../mfcl8900cdwcupswrapper/package.nix { mfcl8900cdwlpr = mfcl8900cdwlpr; });
in
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	#journalctl --follow --unit=cups
	#journalctl --follow --unit=cups | grep -C10 --color=always -i -e 'No such file or directory' -e 'error:'
	#http://localhost:631/printers/

	# Printing
	services.printing.enable = true;
	systemd.services.cups-browsed.enable = false;
	
	services.printing.extraConf = ''
    DefaultEncryption Never
  '';
	
	services.printing.drivers = [
		pkgs.gutenprint
		pkgs.gutenprintBin
		pkgs.brgenml1lpr
		pkgs.brgenml1cupswrapper
		pkgs.brlaser
		pkgs.mfcl3770cdwlpr
		pkgs.mfcl8690cdwcupswrapper
		mfcl8900cdwlpr
		mfcl8900cdwcupswrapper
	];
	services.printing.logLevel = "debug";
	
	#programs.nix-ld.enable = true; # for mfcl8900
	
	
	hardware.printers = {
		ensurePrinters = [
			#https://discourse.nixos.org/t/declarative-printer-setup-missing-driver/33777/6
			{
				name = "Brother_MFCL8900CDW";
				location = "Cornwall";
				deviceUri = "ipp://10.5.5.14";
				#deviceUri = "ipp://cornwall-printer.infra.dsaul.ca";
				model = "brother_mfcl8900cdw_printer_en.ppd";
				#model = "brother_mfcl8690cdw_printer_en.ppd";
				#ppdOptions = {
				#	PageSize = "Letter";
				#	Duplex = "DuplexNoTumble";
				#	Resolution = "600dpi";
				#	PrintQuality = "4";
				#	PwgRasterDocumentType = "Rgb_8";
				#};
			}
		];
		ensureDefaultPrinter = "Brother_MFCL8900CDW";
	};
}
