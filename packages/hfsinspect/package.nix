{ stdenv
, lib
, fetchFromGitHub
, libuuid
}:
stdenv.mkDerivation (finalAttrs: {
	pname = "hfsinspect";
	version = "unstable-rjvb-2018-09-16";

	src = fetchFromGitHub {
		owner = "RJVB";
		repo = "hfsinspect";
		rev = "a5d0a25b9fc433faf62f71a1895be0052e892d66";
		hash = "";
	};


	nativeBuildInputs = [
		autoconf
		automake
		pkg-config
	];
	buildInputs = [
		libuuid
	];


	installPhase = ''
	runHook preInstall
	mkdir -p $out/bin
	make install PREFIX=$out
	runHook postInstall
	'';

	

	#postInstall = ''
	#	wrapProgram "$out/bin/BasiliskII" --set SDL_VIDEODRIVER wayland
	#'';

	meta = with lib; {
		description = "An open-source HFS+ filesystem explorer and debugger (in the spirit of hfsdebug) ";
		homepage = "https://github.com/RJVB/hfsinspect;
		license = licenses.mit;
		maintainers = with maintainers; [  ];
		platforms = platforms.linux;
		mainProgram = "BasiliskII";
	};
})
