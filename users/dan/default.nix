{ config, lib, pkgs, modulesPath, ... }:
let 
	username = "dan";
	fullName = "Dan Saul";
in
{	
	environment.etc = {
		"usericons.d/${username}".source = "${./icon.png}";
	};
	
	age.secrets."userHashedPasswordFile-${username}".file = ../../secrets/userHashedPasswordFile-${username}.age;
	
	users.users."${username}" = {
		uid=1000;
		isNormalUser = true;
		description = fullName;
		hashedPasswordFile = config.age.secrets."userHashedPasswordFile-${username}".path;
		createHome = true;
		extraGroups = [
			"networkmanager"
			"wheel"
			"docker"
			"libvirtd"
			"media"
		];
		packages = with pkgs; [

		];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd"
		];
	};
	
}