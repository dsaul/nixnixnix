{ config, lib, pkgs, modulesPath, ... }:
{
	environment.etc = {
		"usericons.d/dan".source = ${./dan.png};
	}
	
	
	
	environment.systemPackages = with pkgs; [
		
	];	
}
