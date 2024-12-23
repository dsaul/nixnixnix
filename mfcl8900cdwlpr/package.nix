{
coreutils,
dpkg,
fetchurl,
file,
ghostscript,
gnugrep,
gnused,
makeWrapper,
perl,
pkgs,
lib,
stdenv,
which,
}:

stdenv.mkDerivation rec {
	pname = "mfcl8900cdwlpr";
	version = "1.5.0-0";

	src = fetchurl {
		url = "http://download.brother.com/welcome/dlf103242/${pname}-${version}.i386.deb";
		hash = "sha256-+TWcnO4dInPzSrqsjx8qHJPtUllmptbNdkJSRQu4Igc=";
	};

	nativeBuildInputs = [
		dpkg
		autoPatchelfHook
		makeWrapper
	];

	dontUnpack = true;

	installPhase = ''
		dpkg-deb -x $src $out

		dir=$out/opt/brother/Printers/mfcl8900cdw
		filter=$dir/lpd/filter_mfcl8900cdw

		substituteInPlace $filter \
		--replace /usr/bin/perl ${perl}/bin/perl \
		--replace "BR_PRT_PATH =~" "BR_PRT_PATH = \"$dir/\"; #" \
		--replace "PRINTER =~" "PRINTER = \"mfcl8900cdw\"; #"

		wrapProgram $filter \
		--prefix PATH : ${
			lib.makeBinPath [
			coreutils
			file
			ghostscript
			gnugrep
			gnused
			which
			]
		}

		# need to use i686 glibc here, these are 32bit proprietary binaries
		interpreter=${pkgs.pkgsi686Linux.glibc}/lib/ld-linux.so.2
		patchelf --set-interpreter "$interpreter" $dir/lpd/i686/brmfcl8900cdwfilter
	'';

	meta = {
		description = "Brother MFC-L8900CDW LPR printer driver";
		homepage = "http://www.brother.com/";
		sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
		license = lib.licenses.unfree;
		maintainers = [ ];
		platforms = [
		"x86_64-linux"
		"i686-linux"
		];
	};
}
