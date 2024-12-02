{ config, lib, pkgs, modulesPath, ... }:
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	# Expected Packages	
	environment.systemPackages = with pkgs; [
		dig
		wget
		curl
		yt-dlp
		wireguard-tools
	];	
}
