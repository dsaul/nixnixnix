{ stdenv, pkgs }:
stdenv.mkDerivation rec {
  name = "mfcl8900cdw-${version}";
  version = "2024.10.21";

  src = ./.;

  buildInputs = [ pkgs.perl ];

  installPhase = ''
    mkdir -p $out/share/cups/model/
    mkdir -p $out/lib/cups/filter/
    cp brother_mfcl8900cdw_printer_en.ppd $out/share/cups/model/
    cp brother_lpdwrapper_mfcl8900cdw $out/lib/cups/filter/
    chmod +x $out/lib/cups/filter/brother_lpdwrapper_mfcl8900cdw
  '';
}
