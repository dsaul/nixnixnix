{ config, lib, pkgs, modulesPath, ... }:
let 
	username = "tv";
	fullName = "TV";
in
{
	environment.etc = {
		"usericons.d/${username}".source = "${./icon.jpg}";
	};
	
	age.secrets."userHashedPasswordFile-${username}".file = ../../secrets/userHashedPasswordFile-${username}.age;
	
	users.users."${username}" = {
		uid=1999;
		isNormalUser = true;
		description = fullName;
		hashedPasswordFile = config.age.secrets."userHashedPasswordFile-${username}".path;
		createHome = true;
		extraGroups = [
			"networkmanager"
			"media"
		];
		packages = with pkgs; [

		];
	};
	
}
