{ stdenv
, lib
, fetchFromGitHub
, autoconf
, automake
, pkg-config
, SDL2
, SDL2_sound
, SDL2_image
, gtk2
, mpfr
, libICE
, ncurses
, readline
, libadwaita
, gnome-themes-extra
, makeWrapper
}:
stdenv.mkDerivation (finalAttrs: {
	pname = "hfsinspect";
	version = "unstable-rjvb-2025-01-30";

	src = fetchFromGitHub {
		owner = "RJVB";
		repo = "hfsinspect";
		rev = "a5d0a25b9fc433faf62f71a1895be0052e892d66";
		hash = "";
	};
	sourceRoot = "${finalAttrs.src.name}";
	patches = [ 
		
	];
	nativeBuildInputs = [
		autoconf
		automake
		pkg-config
	];
	buildInputs = [
		SDL2
		SDL2_sound
		SDL2_image
		SDL2.dev
		gtk2
		mpfr
		libICE
		ncurses
		readline
		libadwaita
		makeWrapper
	];

	

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
