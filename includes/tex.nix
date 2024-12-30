{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	environment.systemPackages = with pkgs; [
		texmaker
		texliveFull
		perlPackages.YAMLTiny #latexindent
		perlPackages.FileHomeDir #latexindent
		perlPackages.UnicodeLineBreak #latexindent
	];	
}
