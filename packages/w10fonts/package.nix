{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
	pname = "w10fonts";

	src = fetchFromGitHub {
	#owner = "";
	#repo = "";
	#rev = "";
	#hash = "";
	};

	installPhase = ''
	runHook preInstall

	#install -Dm644 -t $out/share/fonts/opentype fonts/otf/*
	#install -m444 -Dt $out/share/fonts/truetype *.ttf
	runHook postInstall
	'';

	meta = with lib; {
	platforms = platforms.all;
	};
}
