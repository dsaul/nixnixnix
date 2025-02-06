{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-whishper";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-whishper.desktop << EOF
[Desktop Entry]
Type=Application
Name=Whishper
Comment=
Icon=webapp-whishper
Exec=chromium --app="https://whishper.dsaul.ca/" %U
Terminal=false
Categories=Office
StartupWMClass=chrome-whishper.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/logo.svg} $out/share/icons/hicolor/scalable/apps/webapp-whishper.svg
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.