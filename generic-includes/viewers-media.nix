{ config, lib, pkgs, modulesPath, ... }:
let
	#grayjay = (pkgs.callPackage ../packages/grayjay.nix {});
in
{
	environment.systemPackages = with pkgs; [
		vlc
		mplayer
		spotify
		calibre
		#grayjay
	];	
	
}