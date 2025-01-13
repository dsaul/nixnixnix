{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-immich";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-immich.desktop << EOF
[Desktop Entry]
Type=Application
Name=Immich
Comment=
Icon=webapp-immich
Exec=chromium --app="https://immich.dsaul.ca/" %U
Terminal=false
Categories=Graphics
StartupWMClass=chrome-immich.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/icon-transparent.png} $out/share/icons/hicolor/scalable/apps/webapp-immich.png
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.
#https://specifications.freedesktop.org/menu-spec/latest/category-registry.html