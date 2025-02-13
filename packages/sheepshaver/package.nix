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
  version = "unstable-kanjitalk755-2025-01-30";

  src = fetchFromGitHub {
    owner = "dsaul";
    repo = "macemu";
	rev = "583d890b93cbc9ec9bcf4b53c95ade272c75572a";
    hash = "";
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
