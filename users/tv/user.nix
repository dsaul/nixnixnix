
{ config, lib, pkgs, modulesPath, ... }:

{

	users.users.tv = {
		uid=1999;
		isNormalUser = true;
		description = "TV";
		hashedPassword = "$y$j9T$0Aj5Gx4w/9139z1kNZJrj1$.kAIIBxO9zkq0IsRDi6dP8ypZKJl8Y67Ee5kVOZVVm8";
		createHome = true;
		extraGroups = [
			"networkmanager"
			"media"
		];
	};



}
