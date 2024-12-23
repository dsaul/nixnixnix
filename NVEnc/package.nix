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
	
	src = pkgs.fetchurl
    {
      url = "https://github.com/rigaya/NVEnc/releases/download/${version}/nvencc_${version}_Ubuntu24.04_amd64.deb";
      hash = "sha256-yl9VSFnKZrhwDGfAjcKbFclghXy2xJtWceAcESyZw9E=";
    };
	
	unpackPhase = "dpkg-deb -x $src/nvencc_${version}_Ubuntu24.04_amd64.deb unpack";
	
	nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook ];
	
	installPhase = ''
      ls -l $src
    '';
	
	
}