
{ config, lib, pkgs, modulesPath, ... }:
let 
	username = "root";
in
{
	age.secrets."userHashedPasswordFile-${username}".file = ../../secrets/userHashedPasswordFile-${username}.age;
	
	users.users."${username}" = {
		hashedPasswordFile = config.age.secrets."userHashedPasswordFile-${username}".path;
		openssh.authorizedKeys.keys = [
		] ++ config.users.users.dan.openssh.authorizedKeys.keys;
	};
}
