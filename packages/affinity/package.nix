# https://github.com/lucasew/nixcfg/blob/master/nix/pkgs/wrapWine.nix
# https://d1gl0nrskhax8d.cloudfront.net/windows/designer2/2.5.7/affinity-designer-2.5.7.msix?Expires=1736807487&Signature=DBMs7mzTkRlgOSA9HbVMXA9eZoGjLUiOuh880RcNgtrK03d8H9nygRqK-v44sKMuXksge4mwCxsQhSXdSzFrbeNwa4VnNZ0hBaVzj1b2VjorsOZLRhKp-biXSKmA6Xr-ZPnQzoRTPi0~CugD0DrjnZ1bjBKwmpOYTMtsAScMTw3z9ru4jcOgEwPqcFcoJF41BPlzk0fmvqTKS5mikv2XCEH-Twn4Dd5GY8oI0T3gyqbCZ4MbfZ9KSuSuUMuFL19NzxiKIYL8zAFCbkMHnJiSUJafnP5px99WngrArXp~Qelm6nfM9ys5TtDDXkJLJhLfDghCllM4PkvUwqijnCV9Mg__&Key-Pair-Id=APKAIMMPYSI7GSVTEAAQ
# https://github.com/emmanuelrosa/erosanix/tree/master/pkgs/mkwindowsapp



# winbox nix file as example starting point:
{
  lib,
  stdenvNoCC,
  fetchurl,
  copyDesktopItems,
  makeDesktopItem,
  makeBinaryWrapper,
  wine,
}:

let
  # The icon is also from the winbox AUR package (see above).
  icon = fetchurl {
    name = "winbox.png";
    url = "https://aur.archlinux.org/cgit/aur.git/plain/winbox.png?h=winbox";
    hash = "sha256-YD6u2N+1thRnEsXO6AHm138fRda9XEtUX5+EGTg004A=";
  };
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "winbox";
  version = "3.41";

  src = fetchurl (
    if (wine.meta.mainProgram == "wine64") then
      {
        url = "https://download.mikrotik.com/routeros/winbox/${finalAttrs.version}/winbox64.exe";
        hash = "sha256-i8Ps8fNZUmAOyxo4DDjIjp1jwIGjIgT9CU1YgjAHC/Y=";
      }
    else
      {
        url = "https://download.mikrotik.com/routeros/winbox/${finalAttrs.version}/winbox.exe";
        hash = "sha256-NypSEC5YKpqldlkSIRFtWVD4xJZcjGcfjnphSg70wmE=";
      }
  );

  dontUnpack = true;

  nativeBuildInputs = [
    makeBinaryWrapper
    copyDesktopItems
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,libexec,share/pixmaps}

    ln -s "${icon}" "$out/share/pixmaps/winbox.png"

    makeWrapper ${lib.getExe wine} $out/bin/winbox \
      --add-flags $src

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "winbox";
      desktopName = "Winbox";
      comment = "GUI administration for Mikrotik RouterOS";
      exec = "winbox";
      icon = "winbox";
      categories = [ "Utility" ];
    })
  ];

  meta = {
    description = "Graphical configuration utility for RouterOS-based devices";
    homepage = "https://mikrotik.com";
    downloadPage = "https://mikrotik.com/download";
    changelog = "https://wiki.mikrotik.com/wiki/Winbox_changelog";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unfree;
    mainProgram = "winbox";
    maintainers = with lib.maintainers; [ yrd ];
  };
})
