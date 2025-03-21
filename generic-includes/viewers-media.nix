{ config, lib, pkgs, modulesPath, ... }:
let
	#grayjay = (pkgs.callPackage ../packages/grayjay.nix {});
in
{
	environment.systemPackages = with pkgs; [
		vlc
		mplayer
		kmplayer #broken
		spotify
		calibre
		totem
		#grayjay
		#supersonic-wayland
		#sublime-music
		(pkgs.callPackage ../packages/webapp-jellyfin/package.nix {})
		(pkgs.callPackage ../packages/webapp-airsonic-advanced/package.nix {})
		#mixxx
	];	
	
}
