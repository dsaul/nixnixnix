{ stdenv
, lib
, fetchFromGitHub
, autoconf
, automake
, pkg-config
, SDL2
, SDL2_sound
, gtk2
, mpfr
, libICE
, ncurses
, readline
, perl
, file
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "sheepshaver";
  version = "unstable-2025-02-10";

  src = fetchFromGitHub {
    owner = "cebix";
    repo = "macemu";
	rev = "96e512bd6376e78a2869f16dcc8a9028bce5ee72";
    hash = "sha256-ZWE51cRAKj8YFkiBHtd1/M5bWElbdNC30gmYk/cmxEo=";
  };
  sourceRoot = "${finalAttrs.src.name}/SheepShaver/src/Unix";
  patches = [ ];
  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
	file
  ];
  buildInputs = [
    SDL2
	SDL2_sound
	SDL2.dev
    gtk2
    mpfr
	libICE
	ncurses
	readline
	perl
  ];
  
  # was in preConfigure before autogen:
  preConfigure = ''
  
  cd ${finalAttrs.src.name}/SheepShaver/
  make links
  cd ${finalAttrs.src.name}/SheepShaver/src/Unix
  
    NO_CONFIGURE=1 ./autogen.sh
  '';
  configureFlags = [
	"--with-sdl2"
    "--enable-sdl-video"
    "--enable-sdl-audio"
    #"--with-bincue"
  ];

  meta = with lib; {
    description = "PPC Macintosh emulator";
    homepage = "https://basilisk.cebix.net/";
    license = licenses.gpl2;
    maintainers = with maintainers; [  ];
    platforms = platforms.linux;
    mainProgram = "SheepShaver";
  };
})
