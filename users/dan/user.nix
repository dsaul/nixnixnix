
{ config, lib, pkgs, modulesPath, ... }:

{
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
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd"
		];
	};


}
