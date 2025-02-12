let
	pkgs = import <nixpkgs> {}; 
in
{
	CiderPress2 = pkgs.callPackage ./package.nix {}
}