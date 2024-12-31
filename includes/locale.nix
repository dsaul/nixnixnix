{ config, lib, pkgs, modulesPath, ... }:

{
	time.timeZone = "America/Winnipeg";
	i18n.defaultLocale = "en_CA.UTF-8";
}
