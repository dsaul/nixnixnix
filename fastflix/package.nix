{
lib,
stdenv,
fetchurl,
fetchFromGitHub,
pkgs,
ffmpeg_6-full,
python312Full,
python3Packages
}:

python3Packages.buildPythonApplication rec {
	pname = "fastflix";
	version = "5.8.2";

	src = fetchFromGitHub {
		owner = "cdgriffith";
		repo = "FastFlix";
		rev = "refs/tags/${version}";
		hash = "sha256-M8vjim5ZX1jTRAi69E2tZE/5BMTxfGztwH2CCYv3TUs=";
	};

	propagatedBuildInputs = with python3Packages; [ setuptools ];

	  # FastFlix dependencies
	propagatedPythonDeps = with python3Packages; [
		pip
		wheel
	];

	  buildPhase = ''
		python -m venv venv
		source venv/bin/activate
		pip install setuptools
		pip install .
	'';

	  installPhase = ''
		mkdir -p $out/bin
		cp -r venv $out/venv
		ln -s $out/venv/bin/python $out/bin/fastflix
	'';

	  # Set up the run environment for `fastflix` script
	postInstall = ''
		wrapProgram $out/bin/fastflix \
		--set PYTHONPATH $out/venv
	'';

	# Runtime test command
	checkPhase = ''
		$out/bin/fastflix --help
	'';

	meta = {
		homepage = "https://fastflix.org/";
		description = "Transcoding assistant.";
		longDescription = ''
			FastFlix is a free GUI for H.264, HEVC and AV1 hardware and software encoding!
		'';
		changelog = "https://github.com/cdgriffith/FastFlix/releases/tag/${version}";
		platforms = lib.platforms.linux;
		runInstructions = ''
			To run FastFlix:

			$ $out/bin/fastflix
		'';
	};
}
