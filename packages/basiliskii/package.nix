{ stdenv
, lib
, fetchFromGitHub
, autoconf
, automake
, pkg-config
, SDL2
, SDL2_sound
, SDL_sound
, gtk2
, mpfr
, libICE
, ncurses
, readline
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "basiliskii";
  version = "unstable-2025-02-10";

  src = fetchFromGitHub {
    owner = "cebix";
    repo = "macemu";
	rev = "96e512bd6376e78a2869f16dcc8a9028bce5ee72";
    hash = "sha256-ZWE51cRAKj8YFkiBHtd1/M5bWElbdNC30gmYk/cmxEo=";
  };
  sourceRoot = "${finalAttrs.src.name}/BasiliskII/src/Unix";
  patches = [ ];
  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
  ];
  buildInputs = [
    SDL2
	SDL2_sound
	SDL_sound
    gtk2
    mpfr
	libICE
	ncurses
	readline
  ];
  preConfigure = ''
    NO_CONFIGURE=1 ./autogen.sh
  '';
  configureFlags = [
    "--enable-sdl-video"
    "--enable-sdl-audio"
    "--with-bincue"
  ];

  meta = with lib; {
    description = "68k Macintosh emulator";
    homepage = "https://basilisk.cebix.net/";
    license = licenses.gpl2;
    maintainers = with maintainers; [  ];
    platforms = platforms.linux;
    mainProgram = "BasiliskII";
  };
})
