{ config, lib, pkgs, modulesPath, ... }:

{
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

	environment.sessionVariables = rec {
		PULSE_LATENCY_MSEC = "60";
	};
}
