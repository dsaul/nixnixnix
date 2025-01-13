{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-davis";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-davis.desktop << EOF
[Desktop Entry]
Type=Application
Name=Davis
Comment=CalDav/CardDav Settings
Icon=webapp-davis
Exec=chromium --app="https://calendar.dsaul.ca/" %U
Terminal=false
Categories=Settings
StartupWMClass=chrome-calendar.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/logo.png} $out/share/icons/hicolor/scalable/apps/logo.png
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.