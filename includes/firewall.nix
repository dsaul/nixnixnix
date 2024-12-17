{ config, lib, pkgs, modulesPath, ... }:
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	# Open ports in the firewall.
	#networking.firewall.allowedTCPPorts = [  ];
	#networking.firewall.allowedUDPPorts = [  ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;	
}
