{ config, lib, pkgs, modulesPath, ... }:
let
	unstable = import <nixos-unstable> { 
		system = "x86_64-linux"; 
		config.allowUnfree = true; 
		config.allowBroken = true; 
	};
	in
{
	# Expected Packages	
	environment.systemPackages = with pkgs; [
		dig
		wget
		curl
		unstable.yt-dlp
		wireguard-tools
		inetutils
	];	
}
