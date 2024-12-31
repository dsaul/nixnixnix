{ config, lib, pkgs, modulesPath, ... }:

{
	environment.systemPackages = with pkgs; [
		texmaker
		texliveFull
		perlPackages.YAMLTiny #latexindent
		perlPackages.FileHomeDir #latexindent
		perlPackages.UnicodeLineBreak #latexindent
	];	
}
