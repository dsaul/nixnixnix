{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in
{
	environment.systemPackages = with pkgs; [
		(pkgs.callPackage ../packages/audiblez/package.nix {
			python = unstable.python313Packages;
		})
	];
}



