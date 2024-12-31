{ config, lib, pkgs, modulesPath, ... }:
let
	#grayjay = (pkgs.callPackage ../packages/grayjay.nix {});
in
{
	environment.systemPackages = with pkgs; [
		kid3-qt
		vlc
		mplayer
		spotify
		mkvtoolnix
		metamorphose2
		handbrake
		calibre
		flac
		#grayjay
	];	
	
}
