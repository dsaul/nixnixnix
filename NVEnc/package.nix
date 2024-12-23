{ lib
, stdenv
, pkgs
#, fetchurl
#, fetchFromGitHub
#, fetchPypi
#, ffmpeg_7-full
#, python312Full
#, python312Packages
#, makeDesktopItem
}:

stdenv.mkDerivation rec {
	pname = "NVEnc";
	version = "7.77";
	format = "pyproject";
	
	src = fetchFromGitHub {
		owner = "rigaya";
		repo = "NVEnc";
		rev = "refs/tags/${version}";
		hash = "sha256-M8vjim5ZX1jTRAi69E2tZE/5BMTxfGztwH2CCYv3TUs=";
	};
	
}