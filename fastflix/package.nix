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
		hash = "sha256-3af7312cf5f6238a9bd6fb4f23b7907442219818590a82086010cb8c22b1c25c";
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
