{ pkgs ? import <nixpkgs> {} }:
#nix-store --gc
#nix-build default.nix -A seafile

with pkgs;

let
  seafile = appimageTools.wrapType1 {
    name = "seafile";
    version = "9.0.8";

    src = fetchurl {
      url = "https://s3.eu-central-1.amazonaws.com/download.seadrive.org/Seafile-x86_64-9.0.8.AppImage";
      sha256 = "094d7a6f95fd068314696e016e6d7deb76ed768f5968342717ff2f717b716018";
    };

    postFixup = ''
      # Copy the icon to the appropriate directory
      mkdir -p $out/share/icons/hicolor/16x16/apps
      mkdir -p $out/share/icons/hicolor/22x22/apps
      mkdir -p $out/share/icons/hicolor/24x24/apps
      mkdir -p $out/share/icons/hicolor/32x32/apps
      mkdir -p $out/share/icons/hicolor/48x48/apps
      mkdir -p $out/share/icons/hicolor/128x128/apps
      mkdir -p $out/share/icons/hicolor/scalable/apps

      cp $appdir/usr/share/icons/hicolor/16x16/apps/seafile.png $out/share/icons/hicolor/16x16/apps/seafile.png
      cp $appdir/usr/share/icons/hicolor/22x22/apps/seafile.png $out/share/icons/hicolor/22x22/apps/seafile.png
      cp $appdir/usr/share/icons/hicolor/24x24/apps/seafile.png $out/share/icons/hicolor/24x24/apps/seafile.png
      cp $appdir/usr/share/icons/hicolor/32x32/apps/seafile.png $out/share/icons/hicolor/32x32/apps/seafile.png
      cp $appdir/usr/share/icons/hicolor/48x48/apps/seafile.png $out/share/icons/hicolor/48x48/apps/seafile.png
      cp $appdir/usr/share/icons/hicolor/128x128/apps/seafile.png $out/share/icons/hicolor/128x128/apps/seafile.png
      cp $appdir/usr/share/icons/hicolor/scalable/apps/seafile.png $out/share/icons/hicolor/scalable/apps/seafile.png
    '';
  };

  # Create the desktop entry
  seafile-desktop = writeTextDir "share/applications/seafile908.desktop" ''
    [Desktop Entry]
    Version=9.0.8
    Type=Application
    Name=Seafile
    Exec=${seafile}/bin/seafile
    Icon=${seafile}/share/icons/hicolor/scalable/apps/seafile.png
    StartupWMClass=AppRun
  '';
in
{
  inherit seafile seafile-desktop;
}
