
{ config, lib, pkgs, modulesPath, ... }:

{
	services.openssh = {
		enable = true;
		settings.PasswordAuthentication = false;
		settings.KbdInteractiveAuthentication = false;
		settings.PermitRootLogin = "yes";
	};
	programs.ssh.startAgent = true;
}
