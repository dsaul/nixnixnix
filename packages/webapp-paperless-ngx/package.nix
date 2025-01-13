{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-paperless-ngx";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-paperless-ngx.desktop << EOF
[Desktop Entry]
Type=Application
Name=paperless-ngx
Comment=
Icon=webapp-paperless-ngx
Exec=chromium --app="https://paperless.dsaul.ca/" %U
Terminal=false
Categories=Office
StartupWMClass=chrome-paperless-ngx.dsaul.ca__-Default
EOF

	install -Dm644 ${./resources/paperless.svg} $out/share/icons/hicolor/scalable/apps/webapp-paperless-ngx.svg
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.