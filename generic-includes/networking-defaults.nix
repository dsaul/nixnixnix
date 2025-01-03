{ config, lib, pkgs, modulesPath, ... }:
{
	# Expected Packages	
	environment.systemPackages = with pkgs; [
		dig
		wget
		curl
		yt-dlp
		wireguard-tools
		inetutils
	];	
}
