{ config, lib, pkgs, modulesPath, ... }:
let
	#grayjay = (pkgs.callPackage ../packages/grayjay.nix {});
in
{
	environment.systemPackages = with pkgs; [
		vlc
		mplayer
		kmplayer
		spotify
		calibre
		#grayjay
		supersonic-wayland
		sublime-music
		(pkgs.callPackage ../packages/webapp-jellyfin/package.nix {})
		(pkgs.callPackage ../packages/webapp-airsonic-advanced/package.nix {})
		#mixxx
	];	
	
}
