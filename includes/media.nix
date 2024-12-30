{ config, lib, pkgs, modulesPath, ... }:
let
	#grayjay = (pkgs.callPackage ../packages/grayjay.nix {});
in
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	environment.systemPackages = with pkgs; [
		kid3-qt
		vlc
		mplayer
		spotify
		mkvtoolnix
		metamorphose2
		handbrake
		calibre
		#unstable.jellyfin-media-player
		flac
		#feishin
		#unstable.delfin
		#grayjay
	];	
	
}
