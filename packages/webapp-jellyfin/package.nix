{ lib
, stdenvNoCC
, ungoogled-chromium
, makeDesktopItem
, imagemagick
}:
let
	terminalName = "webapp-jellyfin";
	displayName = "Jellyfin";
	startupWMClass = "chrome-jellyfin.dsaul.ca__-Default";
in
stdenvNoCC.mkDerivation {
	
	name = "webapp-jellyfin";
	src = ./.;
	
	nativeBuildInputs = [
		imagemagick # convert
	];
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/${terminalName}.desktop << EOF
[Desktop Entry]
Type=Application
Name=${displayName}
Comment=
Icon=${terminalName}
Exec=chromium --app="https://jellyfin.dsaul.ca/" %U
Terminal=false
Categories=AudioVideo;Video
StartupWMClass=${startupWMClass}
EOF
	for i in 16 24 48 64 96 128 256 512 1024; do
		mkdir -p $out/share/icons/hicolor/''${i}x''${i}/apps
		convert -background none -resize ''${i}x''${i} ${./resources/icon-transparent.png} $out/share/icons/hicolor/''${i}x''${i}/apps/${terminalName}.png
	done
	'';

}
#qdbus org.kde.KWin /KWin queryWindowInfo
#StartupWMClass=
#StartupWMClass was set to the resourceClass and this worked.