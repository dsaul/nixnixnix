{ config, lib, pkgs, modulesPath, stdenv, ... }:

{
	
	environment.systemPackages = with pkgs; [
		(stdenv.mkDerivation rec {
			pname = "dan-icon";
			version = "1";
			
			installPhase = ''
				cp ${./dan.png} $out/var/lib/AccountsService/icons/dan
			'';
			
			# /var/lib/AccountsService/icons/
			
		})
	];	
}
