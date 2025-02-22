{ stdenv
, lib
, fetchgit
, libuuid
, libbsd
, pkg-config
}:
stdenv.mkDerivation {
	pname = "hfsinspect";
	version = "unstable-rjvb-2018-09-16";

	src = fetchgit {
		url = "https://github.com/RJVB/hfsinspect.git";
		rev = "02e0853b68e13cdb3dff5b82056bc17ae96275c9";
		hash = "sha256-tZHNNmOiEKDqCEvzYBKW/4vumMabv486y9va9+sjRfw=";
		fetchSubmodules = true;
	};

	nativeBuildInputs = [
		pkg-config
	];

	buildInputs = [
		libuuid
		libbsd
	];

	prePatch = ''
        rm -f Vagrantfile
    '';

	installPhase = ''
runHook preInstall
mkdir -p $out/bin
make install PREFIX=$out
runHook postInstall
	'';

	

	meta = with lib; {
		description = "An open-source HFS+ filesystem explorer and debugger (in the spirit of hfsdebug) ";
		homepage = "https://github.com/RJVB/hfsinspect";
		license = licenses.mit;
		maintainers = with maintainers; [  ];
		platforms = platforms.linux;
	};
}
