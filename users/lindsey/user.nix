
{ config, lib, pkgs, modulesPath, ... }:

{

	users.users.lindsey = {
		uid=1001;
		isNormalUser = true;
		description = "Lindsey Childs";
		hashedPassword = "$y$j9T$vTHzQzDXDSxawblr0TXad0$YOrC7630fGaHOnJTuvkFx5Bxj3uoR5o8ohsXh5QU6v9";
		createHome = true;
		extraGroups = [
			"networkmanager"
			"libvirtd"
		];
		packages = with pkgs; [

		];
	};


}
