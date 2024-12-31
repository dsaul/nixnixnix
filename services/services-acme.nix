
{ config, lib, pkgs, modulesPath, ... }:

{
	security.acme.acceptTerms = true;
	security.acme.defaults.email = "dan@dsaul.ca";
}
