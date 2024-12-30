{ config, lib, pkgs, modulesPath, ... }:
let 
	username = "lindsey";
	fullName = "Lindsey Childs";
in
{
	environment.etc = {
		"usericons.d/${username}".source = "${./icon.jpg}";
	};
	
	age.secrets."userHashedPasswordFile-${username}".file = ../../secrets/userHashedPasswordFile-${username}.age;
	
	users.users."${username}" = {
		uid=1001;
		isNormalUser = true;
		description = fullName;
		hashedPasswordFile = config.age.secrets."userHashedPasswordFile-${username}".path;
		createHome = true;
		extraGroups = [
			"networkmanager"
			"libvirtd"
		];
		packages = with pkgs; [

		];
	};
	
}
