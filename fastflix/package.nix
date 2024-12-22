{
lib,
stdenv,
fetchurl,
fetchFromGitHub,
pkgs,
ffmpeg_6-full,
python312Full,
python312Packages
}:

python312Packages.buildPythonApplication rec {
	pname = "fastflix";
	version = "5.8.2";
	format = "pyproject";

	src = fetchFromGitHub {
		owner = "cdgriffith";
		repo = "FastFlix";
		rev = "refs/tags/${version}";
		hash = "sha256-M8vjim5ZX1jTRAi69E2tZE/5BMTxfGztwH2CCYv3TUs=";
	};

	#env.SETUPTOOLS_SCM_PRETEND_VERSION = ;

	propagatedPythonDeps = with python312Packages; [
		annotated-types
		appdirs # appdirs~=1.4
		certifi
		chardet # chardet<5.2.0,>=5.1.0
		"charset-normalizer"
		colorama # colorama<1.0,>=0.4
		coloredlogs # coloredlogs<16.0,>=15.0
		# iso639-lang==0.0.9
		humanfriendly
		idna
		mistune # mistune<3.0,>=2.0
		msgpack
		packaging # packaging>=23.2
		pathvalidate # pathvalidate<3.0,>=2.4
		pip
		psutil # psutil<6.0,>=5.9
		pydantic # pydantic<3.0,>=2.0
		pydantic-core
		pyside6 # pyside6==6.7.2
		python-box # python-box[all]<7.0,>=6.0
		requests # requests<3.0,>=2.28
		ruamel-yaml
		ruamel-yaml-clib
		setuptools
		setuptools-scm
		shiboken6
		toml

		urllib3
		# reusables<0.10.0,>=0.9.6
	];

	propagatedBuildInputs = with python312Packages; [
		wheel # wheel>=0.38.4
		typing-extensions # typing_extensions>=4.4
		pyinstaller # pyinstaller==6.9.0
		pytest # pytest>=7.3 # types-requests>=2.28
		types-setuptools # types-setuptools>=65.7
		types-requests
		pre-commit-hooks # pre-commit>=3.0.3
		setuptools
		setuptools-scm
	];



	#buildPhase = ''
	#	python -m venv venv
	#	source venv/bin/activate
	#	#pip install --no-cache-dir  setuptools
	#	#pip install --no-cache-dir  .
	#'';








	  # FastFlix dependencies
	#propagatedPythonDeps = with python312Packages; [
	#	setuptools
	#	pip
	#	wheel
	#];

	#buildPhase = ''
	#	python -m venv venv
	#	source venv/bin/activate
	#	#pip install --no-cache-dir  setuptools
	#	#pip install --no-cache-dir  .
	#'';

	#installPhase = ''
	#	mkdir -p $out/bin
	#	cp -r venv $out/venv
	#	ln -s $out/venv/bin/python $out/bin/fastflix
	#'';

	# Set up the run environment for `fastflix` script
	#postInstall = ''
	#	wrapProgram $out/bin/fastflix \
	#	--set PYTHONPATH $out/venv
	#'';

	# Runtime test command
	#checkPhase = ''
	#	$out/bin/fastflix --help
	#'';

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
