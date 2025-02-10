{ config, lib, pkgs, modulesPath, ... }:
let
	#grayjay = (pkgs.callPackage ../packages/grayjay.nix {});
in
{
	environment.systemPackages = with pkgs; [
		vlc
		mplayer
		#kmplayer #broken
		spotify
		calibre
		#grayjay
		(pkgs.callPackage ../packages/grayjay-desktop/default.nix {
			internal = {
				grayjay-web = (pkgs.callPackage ../packages/grayjay-web/default.nix {});
			};
		})
		supersonic-wayland
		sublime-music
		(pkgs.callPackage ../packages/webapp-jellyfin/package.nix {})
		(pkgs.callPackage ../packages/webapp-airsonic-advanced/package.nix {})
		#mixxx
	];	
	
}
