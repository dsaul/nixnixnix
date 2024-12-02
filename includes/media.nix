{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	environment.systemPackages = with pkgs; [
		par2cmdline-turbo
		kid3-qt
		vlc
		mplayer
		ffmpeg_7-full
		spotify
		mkvtoolnix
		metamorphose2
		handbrake
		calibre
		#unstable.jellyfin-media-player
		flac
		#feishin
		#unstable.delfin
	];	
	
}
