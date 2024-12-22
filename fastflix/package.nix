{
lib,
stdenv,
fetchurl,
pkgs,
ffmpeg_6-full,
python312Full
}:

stdenv.mkDerivation (finalAttrs: {
	pname = "fastflix";
	version = "5.8.2";

	src = fetchurl {
		url = "https://github.com/cdgriffith/FastFlix/archive/refs/tags/${finalAttrs.version}.tar.gz";
		hash = "sha256-VDlJsEJtdRhYAp8pOEAIp5lov+UUcRf29JCDT82tRkU=";
	};

	nativeBuildInputs = [ pkgs.python312Full ];

	installPhase = ''
		runHook preInstall

		#cd FastFlix
		#python3.12 -m pip install --upgrade pip
		#python3.12 -m venv venv
		#. ./venv/bin/activate       # venv\Scripts\activate.bat or venv\Scripts\activate.ps1 on windows
		#pip install setuptools
		#pip install .

		runHook postInstall
	'';

	#venv/bin/python -m fastflix

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
