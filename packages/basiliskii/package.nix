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
, libadwaita
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "basiliskii";
  version = "unstable-kanjitalk755-2025-01-30";

  src = fetchFromGitHub {
    owner = "kanjitalk755";
    repo = "macemu";
	rev = "6ddff7bc02c5966a064c7df7bf400d10b3994c87";
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
	SDL2.dev
    gtk2
    mpfr
	libICE
	ncurses
	readline
	libadwaita
  ];
  
  # was in preConfigure before autogen:
  preConfigure = ''
    NO_CONFIGURE=1 ./autogen.sh
  '';
  configureFlags = [
	#"--with-gtk"
	"--with-sdl2"
    "--enable-sdl-video"
    "--enable-sdl-audio"
    "--with-bincue"
	#"--with-libvhd"
	#"--with-vdeplug"
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
