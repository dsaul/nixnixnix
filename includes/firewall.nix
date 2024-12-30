{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in 
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
