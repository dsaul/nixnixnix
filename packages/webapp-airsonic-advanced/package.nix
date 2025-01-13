{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-airsonic-advanced";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-airsonic-advanced.desktop << EOF
[Desktop Entry]
Type=Application
Name=Airsonic Advanced
Comment=
Icon=webapp-airsonic-advanced
Exec=chromium --app="https://airsonic.dsaul.ca/" %U
Terminal=false
Categories=AudioVideo;Audio
StartupWMClass=chrome-airsonic.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/safari-pinned-tab.svg} $out/share/icons/hicolor/scalable/apps/webapp-airsonic-advanced.png
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.