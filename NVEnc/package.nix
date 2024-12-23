{ lib
, stdenv
, pkgs
#, fetchurl
, fetchFromGitHub
#, fetchPypi
, ffmpeg_7-full
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
	
	#unpackPhase = "";
	
	nativeBuildInputs = with pkgs; [
		dpkg
		autoPatchelfHook
	];

	buildInputs = with pkgs; [
		glibc
		gcc
		libass
		ffmpeg_6
		cudatoolkit
		#nvidia-x11
	];
	# https://nixos.org/manual/nixpkgs/stable/#setup-hook-autopatchelfhook
	autoPatchelfIgnoreMissingDeps = [
		"libcuda.so.1"
	];
	
	installPhase = ''
		dpkg-deb -X $src $out
		mkdir -p $out/bin
		mv $out/usr/bin/* $out/bin/
		rmdir $out/usr/bin || true
	'';
	
	
}