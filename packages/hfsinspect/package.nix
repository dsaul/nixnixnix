{ stdenv
, lib
, fetchgit
, libuuid
, libbsd
}:
stdenv.mkDerivation {
	pname = "hfsinspect";
	version = "unstable-ahknight-2015-03-03";

	src = fetchgit {
		url = "https://github.com/ahknight/hfsinspect.git";
		rev = "02e0853b68e13cdb3dff5b82056bc17ae96275c9";
		hash = "sha256-tZHNNmOiEKDqCEvzYBKW/4vumMabv486y9va9+sjRfw=";
		fetchSubmodules = true;
	};

	buildInputs = [
		libuuid
		libbsd
	];


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
