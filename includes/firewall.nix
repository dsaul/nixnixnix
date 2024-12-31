{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in 
{
	# Open ports in the firewall.
	#networking.firewall.allowedTCPPorts = [  ];
	#networking.firewall.allowedUDPPorts = [  ];
}
