{ lib
, stdenvNoCC
, fetchurl
, wine
, winetricks
}:

stdenvNoCC.mkDerivation (finalAttrs: {
	
	pname = "affinity-photo";
	version = "2.5.7";
	
	src = /home/dan/Downloads/affinity-photo-msi-2.5.7.exe

	dontUnpack = true;

	meta = {
		#description = "Graphical configuration utility for RouterOS-based devices";
		#homepage = "https://mikrotik.com";
		#downloadPage = "https://mikrotik.com/download";
		#changelog = "https://wiki.mikrotik.com/wiki/Winbox_changelog";
		sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
		license = lib.licenses.unfree;
		#mainProgram = "winbox";
		maintainers = with lib.maintainers; [ ];
	};
})
