{ config, lib, pkgs, modulesPath, ... }:
let
	icon = (pkgs.stdenv.mkDerivation rec {
			pname = "dan-icon";
			version = "1";
			
			src = ./dan.png;
			
			dontUnpack = true;
			
			installPhase = ''
				mkdir -p $out/etc/usericons.d/
				cp ${src} $out/etc/usericons.d/dan
			'';
			
			# /var/lib/AccountsService/icons/
			
		});
in
{
	
	environment.systemPackages = with pkgs; [
		icon
	];	
}
