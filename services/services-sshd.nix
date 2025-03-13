
{ config, lib, pkgs, modulesPath, ... }:

{
	age.secrets."id_ed25519-www.dsaul.ca-nixos_package".file = ../../secrets/id_ed25519-www.dsaul.ca-nixos_package.age;
	
	services.openssh = {
		enable = true;
		settings.PasswordAuthentication = false;
		settings.KbdInteractiveAuthentication = false;
		settings.PermitRootLogin = "yes";
	};
	programs.ssh.startAgent = true;
	#programs.ssh.extraConfig = ''
	#	Host github.com
	#	User root
	#	IdentityFile ${config.age.secrets."id_ed25519-www.dsaul.ca-nixos_package".path}
	#	IdentitiesOnly yes
	#'';
}
