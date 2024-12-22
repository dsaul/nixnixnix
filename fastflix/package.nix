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
		hash = "sha256-543949b0426d751858029f29384008a79968bfe5147117f6f490834fcdad4645";
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
