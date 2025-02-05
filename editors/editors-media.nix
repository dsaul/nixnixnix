{ config, lib, pkgs, modulesPath, ... }:

{
	boot.kernelModules = [ "sg" ]; # for makemkv to find bluray drives
	
	environment.systemPackages = with pkgs; [
		kid3-qt
		mkvtoolnix
		metamorphose2
		handbrake
		flac
		makemkv
		shntool
	];
}
	

