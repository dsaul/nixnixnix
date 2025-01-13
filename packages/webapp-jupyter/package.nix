{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	
	name = "webapp-jupyter";
	src = ./.;
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/webapp-jupyter.desktop << EOF
[Desktop Entry]
Type=Application
Name=Jupyter
Comment=
Icon=webapp-jupyter
Exec=chromium --app="https://jupyter.dsaul.ca/lab?" %U
Terminal=false
Categories=Development
StartupWMClass=chrome-jupyter.dsaul.ca__lab-Default
EOF

	install -Dm644 ${./resources/Jupyter_logo.svg} $out/share/icons/hicolor/scalable/apps/webapp-jupyter.svg
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.