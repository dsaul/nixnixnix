{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	environment.systemPackages = with pkgs; [
                steam
        ];


	# Required for Steam
	hardware.graphics = {
		enable = true;
		extraPackages = with pkgs; [
                        libGL
                ];
		enable32Bit = true;
	};	
}
