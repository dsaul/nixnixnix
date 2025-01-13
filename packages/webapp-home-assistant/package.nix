{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-home-assistant";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-home-assistant.desktop << EOF
[Desktop Entry]
Type=Application
Name=Home Assistant
Comment=
Icon=webapp-home-assistant
Exec=chromium --app="https://homeassistant.dsaul.ca/" %U
Terminal=false
Categories=Settings
StartupWMClass=chrome-homeassistant.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/logo.svg} $out/share/icons/hicolor/scalable/apps/webapp-home-assistant.png
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.
#https://specifications.freedesktop.org/menu-spec/latest/category-registry.html