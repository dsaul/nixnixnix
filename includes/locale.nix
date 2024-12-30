{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	time.timeZone = "America/Winnipeg";
	i18n.defaultLocale = "en_CA.UTF-8";
}
