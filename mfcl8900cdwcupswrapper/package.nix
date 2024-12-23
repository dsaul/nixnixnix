{
coreutils,
dpkg,
fetchurl,
gnugrep,
gnused,
makeWrapper,
mfcl8900cdwlpr,
perl,
lib,
stdenv,
autoPatchelfHook,
pkgs
}:

stdenv.mkDerivation rec {
	pname = "mfcl8900cdwcupswrapper";
	version = "1.5.0-0";

	src = fetchurl {
		url = "http://download.brother.com/welcome/dlf103251/${pname}-${version}.i386.deb";
		hash = "sha256-XmfzLwnOw9DDzVwEDLIL07nPEUffCB1KcDya8B+9yss=";
	};
	
	buildInputs = with pkgs; [
		glibc
		gcc
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
		--replace /usr/bin/perl ${perl}/bin/perl \
		--replace "basedir =~" "basedir = \"$basedir/\"; #" \
		--replace "PRINTER =~" "PRINTER = \"mfcl8900cdw\"; #"

		wrapProgram $dir/cupswrapper/brother_lpdwrapper_mfcl8900cdw \
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
		homepage = "http://www.brother.com/";
		license = lib.licenses.unfree;
		platforms = lib.platforms.linux;
		maintainers = [ ];
	};
}
