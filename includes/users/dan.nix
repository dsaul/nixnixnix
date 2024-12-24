{ config, lib, pkgs, modulesPath, ... }:
let
	icon = (pkgs.stdenv.mkDerivation rec {
			pname = "dan-icon";
			version = "1";
			
			installPhase = ''
				cp ${./dan.png} $out/var/lib/AccountsService/icons/dan
			'';
			
			# /var/lib/AccountsService/icons/
			
		});
in
{
	
	environment.systemPackages = with pkgs; [
		icon
	];	
}
