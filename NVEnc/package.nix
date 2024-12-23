{ lib
, stdenv
, pkgs
#, fetchurl
, fetchFromGitHub
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
	
	src = pkgs.fetchurl
    {
      url = "https://github.com/rigaya/NVEnc/releases/download/${version}/nvencc_${version}_Ubuntu24.04_amd64.deb";
      hash = "sha256-aWAvwtGrFH2HUNkzLW1WqukIy4NemN9Vrb/DMGYGf5Y=";
    };
	
	unpackPhase = "dpkg-deb -x $src unpack";
	
	nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook ];
	
	installPhase = ''
      ls -l $src
    '';
	
	
}