
{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	# Groups
	users.groups.media = {
		gid=990;
	};

	# Users

	users.mutableUsers = false;

	users.users.dan = {
		uid=1000;
		isNormalUser = true;
		description = "Dan Saul";
		hashedPassword = "$y$j9T$uxY.SUIBXQFEKq062n3RU.$DqLDTeWHslwa8gw/TLK9A0aT0fiCJ18DX4dlsVUH212";
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
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd dan@dsaul.ca"
		];
	};

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


	users.users.tv = {
		uid=1999;
		isNormalUser = true;
		description = "TV";
		hashedPassword = "";
		createHome = true;
		"networkmanager"
		"media"
	};





	users.users.root = {
		hashedPassword = "$y$j9T$htmwtfRKe.JTWSYBFx2t//$vdFRKshNW4quHTF1F76d2zoF7BHNJNAdVAhpNzcyKk1";
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd dan@dsaul.ca"
		];
	};



}
