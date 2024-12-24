{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];


	environment.systemPackages = with pkgs; [
		(pkgs.callPackage ../packages/fastflix/package.nix {})
		(pkgs.callPackage ../packages/NVEnc/package.nix {})
	];
}



