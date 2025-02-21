{ config, lib, pkgs, modulesPath, ... }:

{
	nixpkgs.config.permittedInsecurePackages = [
		"dotnet-sdk-6.0.428" # openra
		"dotnet-runtime-6.0.36" # openra
	];
	
	
	environment.systemPackages = with pkgs; [
		steam
		sunshine
		moonlight-qt
		(pkgs.wrapOBS {
			plugins = with pkgs.obs-studio-plugins; [
				wlrobs
				obs-backgroundremoval
				obs-pipewire-audio-capture
			];
		})
		
		# Games
		ryujinx
		space-cadet-pinball
		parsec-bin
		openra
		retroarchFull
		#yabause # broken
		mednafen
	];


	# Required for Steam
	hardware.graphics = {
		enable = true;
		extraPackages = with pkgs; [
			libGL
		];
		enable32Bit = true;
	};
	
	# Required, otherwise some games will have sound that drops out. Spotify 
	# requires setting it back to defualt specifically for that app, otherwise 
	# it'll then sound like garbage.
	environment.sessionVariables = rec {
		PULSE_LATENCY_MSEC = "60";
	};
}
