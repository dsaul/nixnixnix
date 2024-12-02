{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	environment.systemPackages = with pkgs; [
                steam
		sunshine
		moonlight-qt
		ryujinx
		(pkgs.wrapOBS {
			plugins = with pkgs.obs-studio-plugins; [
				wlrobs
				obs-backgroundremoval
				obs-pipewire-audio-capture
			];
		})
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
