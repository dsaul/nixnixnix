
{ config, lib, pkgs, modulesPath, ... }:
let 
	username = "root";
in
{
	age.secrets."userHashedPasswordFile-${username}".file = ../../secrets/userHashedPasswordFile-${username}.age;
	
	users.users."${username}" = {
		hashedPasswordFile = config.age.secrets."userHashedPasswordFile-${username}".path;
		
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd" # dan
		]
		
		#openssh.authorizedKeys.keys = [
		#] ++ config.users.users.dan.openssh.authorizedKeys.keys;
	};
}
