{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-jellyfin";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-jellyfin.desktop << EOF
[Desktop Entry]
Type=Application
Name=Jellyfin
Comment=
Icon=webapp-jellyfin
Exec=chromium --app="https://jellyfin.dsaul.ca/" %U
Terminal=false
Categories=Multimedia
StartupWMClass=chrome-jellyfin.dsaul.ca-Default
EOF

	install -Dm644 ${./resources/jellyfin.svg} $out/share/icons/hicolor/scalable/apps/webapp-jellyfin.svg
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.