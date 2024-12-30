{lib
, coreutils
, dpkg
, fetchurl
, file
, ghostscript
, gnugrep
, gnused
, makeWrapper
, perl
, pkgs
, stdenv
, which
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
	pname = "mfcl8900cdwlpr";
	version = "1.5.0-0";

	src = fetchurl {
		url = "http://download.brother.com/welcome/dlf103242/${pname}-${version}.i386.deb";
		hash = "sha256-+TWcnO4dInPzSrqsjx8qHJPtUllmptbNdkJSRQu4Igc=";
	};
	
	buildInputs = with pkgs; [
		
	];
	
	#autoPatchelfIgnoreMissingDeps = [
	#	"libstdc++.so.6"
	#];
	

	nativeBuildInputs = [
		stdenv.cc.cc.lib
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
			--replace-fail /usr/bin/perl ${perl}/bin/perl \
			--replace-fail "BR_PRT_PATH =~" "BR_PRT_PATH = \"$dir/\"; #" \
			--replace-fail "PRINTER =~" "PRINTER = \"mfcl8900cdw\"; #"

		wrapProgram $filter \
			--set LPD_DEBUG 1\
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
		
		ln $dir/lpd/x86_64/brmfcl8900cdwfilter $dir/lpd/brmfcl8900cdwfilter
		ln $dir/lpd/x86_64/brprintconf_mfcl8900cdw $dir/lpd/brprintconf_mfcl8900cdw
	'';

	meta = {
		description = "Brother MFC-L8900CDW LPR printer driver";
		longDescription = "Works, but not without issues, print options such as monocrome or duplex don't current work.  Unless you specifically need the official driver, use IPP Everywhere, using the model 'everywhere'.";
		homepage = "https://support.brother.com/g/b/downloadlist.aspx?c=ca&lang=en&prod=mfcl8900cdw_all&os=128";
		sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
		license = lib.licenses.unfree;
		maintainers = [ ];
		platforms = lib.platforms.linux;
	};
}
