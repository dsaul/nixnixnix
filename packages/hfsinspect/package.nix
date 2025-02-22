{ stdenv
, lib
, fetchFromGitHub
, libuuid
, libbsd
}:
stdenv.mkDerivation {
	pname = "hfsinspect";
	version = "unstable-ahknight-2015-03-03";

	src = fetchFromGitHub {
		owner = "ahknight";
		repo = "hfsinspect";
		rev = "02e0853b68e13cdb3dff5b82056bc17ae96275c9";
		hash = "sha256-NoQkcktMDqOu6WCG+tnxJuDVI2o2MHaqCFt7JWuQKJs=";
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
