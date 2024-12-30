# nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [ 
		<agenix/modules/age.nix>
	];

	environment.systemPackages = with pkgs; [
		(pkgs.callPackage <agenix/pkgs/agenix.nix> {})
	];
	
	age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key" "/etc/ssh/ssh_host_rsa_key"];
}
