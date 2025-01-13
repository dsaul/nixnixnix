{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-mealie";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-mealie.desktop << EOF
[Desktop Entry]
Type=Application
Name=Mealie
Comment=
Icon=webapp-mealie
Exec=chromium --app="https://mealie.dsaul.ca/" %U
Terminal=false
Categories=Office
StartupWMClass=chrome-mealie.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/mealie.svg} $out/share/icons/hicolor/scalable/apps/webapp-mealie.svg
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.