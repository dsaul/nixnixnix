
{ config, lib, pkgs, modulesPath, ... }:

{

	users.users.root = {
		hashedPassword = "$y$j9T$htmwtfRKe.JTWSYBFx2t//$vdFRKshNW4quHTF1F76d2zoF7BHNJNAdVAhpNzcyKk1";
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd"
		];
	};



}
