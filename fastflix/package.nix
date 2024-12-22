{
lib,
stdenv,
fetchurl
}:

stdenv.mkDerivation (finalAttrs: {
	pname = "fastflix";
	version = "5.8.2";

	src = fetchurl {
		url = "https://github.com/cdgriffith/FastFlix/archive/refs/tags/${finalAttrs.version}.tar.gz";
		hash = "sha256-OvcxLPX2I4qb1vtPI7eQdEIhmBhZCoIIYBDLjCKxwlw=";
	};



	meta = {
		homepage = "https://fastflix.org/";
		description = "Transcoding assistant.";
		longDescription = ''
			FastFlix is a free GUI for H.264, HEVC and AV1 hardware and software encoding!
		'';
		changelog = "https://github.com/cdgriffith/FastFlix/releases/tag/${finalAttrs.version}";
		platforms = lib.platforms.unix;
	};
})
