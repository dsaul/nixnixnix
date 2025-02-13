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
    owner = "dsaul";
    repo = "macemu";
	rev = "583d890b93cbc9ec9bcf4b53c95ade272c75572a";
    hash = "sha256-hiBNk01K0dkQiRG0uVJ1foRt6m422R7tWfZvTtF0uvc=";
  };
  sourceRoot = "${finalAttrs.src.name}/BasiliskII/src/Unix";
  patches = [ 
	./remove-redhat-6-workaround-for-scsi-sg.h.patch 
	];
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
