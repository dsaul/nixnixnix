{ lib
, stdenv
, pkgs
, fetchurl
, ffmpeg_6
, addDriverRunpath
, makeWrapper
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
		makeWrapper
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
	
	postFixup = ''
	for program in $out/bin/*; do
	  isELF "$program" || continue
	  
	  wrapProgram $program \
		--prefix LD_LIBRARY_PATH : "${
		  lib.makeLibraryPath [
			addDriverRunpath.driverLink
		  ]
		}"
	done
  '';
	
	installPhase = ''
		dpkg-deb -X $src $out
		mkdir -p $out/bin
		mv $out/usr/bin/* $out/bin/
		rmdir $out/usr/bin || true
	'';
	
	
}