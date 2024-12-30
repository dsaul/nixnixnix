{lib
, coreutils
, dpkg
, fetchurl
, gnugrep
, gnused
, makeWrapper
, mfcl8900cdwlpr
, perl
, stdenv
, autoPatchelfHook
, pkgs
}:

stdenv.mkDerivation rec {
	pname = "mfcl8900cdwcupswrapper";
	version = "1.5.0-0";

	src = fetchurl {
		url = "http://download.brother.com/welcome/dlf103251/${pname}-${version}.i386.deb";
		hash = "sha256-XmfzLwnOw9DDzVwEDLIL07nPEUffCB1KcDya8B+9yss=";
	};
	
	buildInputs = with pkgs; [
		
	];
	
	autoPatchelfIgnoreMissingDeps = [
		"libstdc++.so.6"
	];

	nativeBuildInputs = [
		dpkg
		autoPatchelfHook
		makeWrapper
	];

	dontUnpack = true;

	installPhase = ''
		dpkg-deb -x $src $out

		basedir=${mfcl8900cdwlpr}/opt/brother/Printers/mfcl8900cdw
		dir=$out/opt/brother/Printers/mfcl8900cdw

		substituteInPlace $dir/cupswrapper/brother_lpdwrapper_mfcl8900cdw \
			--replace-fail /usr/bin/perl ${perl}/bin/perl \
			--replace-fail "basedir =~" "basedir = \"$basedir/\"; #" \
			--replace-fail "PRINTER =~" "PRINTER = \"mfcl8900cdw\"; #"

		wrapProgram $dir/cupswrapper/brother_lpdwrapper_mfcl8900cdw \
			--set LPD_DEBUG 1\
			--prefix PATH : ${
				lib.makeBinPath [
				coreutils
				gnugrep
				gnused
				]
			}

		mkdir -p $out/lib/cups/filter
		mkdir -p $out/share/cups/model

		ln $dir/cupswrapper/brother_lpdwrapper_mfcl8900cdw $out/lib/cups/filter
		ln $dir/cupswrapper/brother_mfcl8900cdw_printer_en.ppd $out/share/cups/model
	'';

	meta = {
		description = "Brother MFC-L8900CDW CUPS wrapper driver";
		longDescription = "Works, but not without issues, print options such as monocrome or duplex don't current work. Unless you specifically need the official driver, use IPP Everywhere, using the model 'everywhere'.";
		homepage = "https://support.brother.com/g/b/downloadlist.aspx?c=ca&lang=en&prod=mfcl8900cdw_all&os=128";
		license = lib.licenses.unfree;
		platforms = lib.platforms.linux;
		maintainers = [ ];
	};
}
