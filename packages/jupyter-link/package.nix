{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
}:

stdenvNoCC.mkDerivation {
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/fastflix.desktop << EOF
[Desktop Entry]
Type=Application
Name=Jupyter
Comment=
Icon=jupyter-link
Exec=chromium --app="https://jupyter.dsaul.ca/lab?" %U
Terminal=false
Categories=Development
EOF

	install -Dm644 ${./resources/Jupyter_logo.svg} $out/share/icons/hicolor/scalable/apps/jupyter-link.svg
  '';
}