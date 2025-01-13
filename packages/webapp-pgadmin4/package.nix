{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-pgadmin4";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-pgadmin4.desktop << EOF
[Desktop Entry]
Type=Application
Name=pgadmin4
Comment=
Icon=webapp-pgadmin4
Exec=chromium --app="https://pgadmin.dsaul.ca/" %U
Terminal=false
Categories=Development
StartupWMClass=chrome-pgadmin.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/pgadmin.svg} $out/share/icons/hicolor/scalable/apps/webapp-pgadmin4.svg
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.