{ lib
, stdenv
, fetchurl
, fetchFromGitHub
, fetchPypi
, pkgs
, ffmpeg_7-full
, python312Full
, python312Packages
, makeDesktopItem
}:
let
	# https://github.com/NixOS/nixpkgs/blob/00000000b0be738315769701d1bc6ee298ad44a9/pkgs/development/python-modules/chardet/default.nix
	chardet510 = (pkgs.callPackage ./chardet510/default.nix {
		buildPythonPackage = python312Packages.buildPythonPackage;
		hypothesis = python312Packages.hypothesis;
		pytestCheckHook = python312Packages.pytestCheckHook;
		setuptools = python312Packages.setuptools;
	});

	# Not in nixpkgs
	iso639lang = (python312Packages.buildPythonPackage rec {
		pname = "iso639_lang";
		version = "2.5.1";
		format = "pyproject";
		
		nativeBuildInputs = [
			python312Packages.setuptools
		];
		
		src = pkgs.fetchPypi {
			inherit pname version;
			hash = "sha256-yeMR7CtvEAXrNtOgoPa7+CiYy00831aLaq5KBwWhndU=";
		};
	});

	# https://github.com/NixOS/nixpkgs/blob/294f94582559690359b28a044cbe96659091f118/pkgs/development/python-modules/mistune/default.nix
	mistune205 = (pkgs.callPackage ./mistune205/default.nix {
		buildPythonPackage = python312Packages.buildPythonPackage;
		setuptools = python312Packages.setuptools;
		pytestCheckHook = python312Packages.pytestCheckHook;
	});

	# https://github.com/NixOS/nixpkgs/blob/nixos-24.11/pkgs/development/python-modules/pathvalidate/default.nix#L29
	pathvalidate252 = (pkgs.callPackage ./pathvalidate252/default.nix {
		buildPythonPackage = python312Packages.buildPythonPackage;
	});

	# https://github.com/NixOS/nixpkgs/blob/96f7b8213bd9f6aebc4a54815195de827a05b561/pkgs/development/python-modules/psutil/default.nix
	psutil598 = (pkgs.callPackage ./psutil598/default.nix {
		buildPythonPackage = python312Packages.buildPythonPackage;
		pytestCheckHook = python312Packages.pytestCheckHook;
	});

	python-box610 = (pkgs.callPackage ./python-box610/default.nix {
		buildPythonPackage = python312Packages.buildPythonPackage;
		pytestCheckHook = python312Packages.pytestCheckHook;
		pyyaml = python312Packages.pyyaml;
		ruamel-yaml = python312Packages.ruamel-yaml;
		toml = python312Packages.toml;
		tomli = python312Packages.tomli;
		tomli-w = python312Packages.tomli-w;
		cython = python312Packages.cython;
	});

	# https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/development/python-modules/pytest-runner/default.nix#L36
	pytest-runner601 = (pkgs.callPackage ./pytest-runner601/default.nix {
		buildPythonPackage = python312Packages.buildPythonPackage;
		setuptools-scm = python312Packages.setuptools-scm;
		pytest = python312Packages.pytest;
	});


	# Not in nixpkgs
	reusables096 = (python312Packages.buildPythonPackage rec {
		pname = "reusables";
		version = "0.9.6";
		doCheck = false;

		src = pkgs.fetchPypi {
			inherit pname version;
			hash = "sha256-2A5ULQgP7HQUeIUUmMx+X3xiTU7hTXOo/UxIwsbCE1U=";
		};

		nativeBuildInputs = [
			python312Packages.pip
			pytest-runner601
		];
	});


	#shiboken672 = (pkgs.callPackage ./shiboken672/default.nix { python = python312Full; });
	#pyside672 = (pkgs.callPackage ./pyside672/default.nix { shiboken6 = shiboken672; python = python312Full;  });




in
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
	
	patches = [
		./audio_panel.py.patch
		./profile_window.py.patch
		./pyproject.toml.patch
		./settings.py.patch
		./subtitle_panel.py.patch
	];
	

	#env.SETUPTOOLS_SCM_PRETEND_VERSION = ;




	propagatedPythonDeps = with python312Packages; [
		annotated-types
		appdirs # appdirs~=1.4
		certifi
		chardet510#chardet # chardet<5.2.0,>=5.1.0
		charset-normalizer
		colorama # colorama<1.0,>=0.4
		coloredlogs # coloredlogs<16.0,>=15.0
		iso639lang # iso639-lang==0.0.9
		humanfriendly
		idna
		mistune205 # mistune # mistune<3.0,>=2.0
		msgpack
		packaging # packaging>=23.2
		pathvalidate252 # pathvalidate # pathvalidate<3.0,>=2.4
		pip
		psutil598 # psutil # psutil<6.0,>=5.9
		pydantic # pydantic<3.0,>=2.0
		pydantic-core
		pyside6 # pyside6==6.7.2
		python-box610 # python-box # python-box[all]<7.0,>=6.0
		requests # requests<3.0,>=2.28
		ruamel-yaml
		ruamel-yaml-clib
		setuptools
		setuptools-scm
		shiboken6
		toml

		urllib3
		reusables096 # reusables<0.10.0,>=0.9.6
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


		annotated-types
		appdirs # appdirs~=1.4
		certifi
		chardet510#chardet # chardet<5.2.0,>=5.1.0
		charset-normalizer
		colorama # colorama<1.0,>=0.4
		coloredlogs # coloredlogs<16.0,>=15.0
		iso639lang # iso639-lang==0.0.9
		humanfriendly
		idna
		mistune205 # mistune # mistune<3.0,>=2.0
		msgpack
		packaging # packaging>=23.2
		pathvalidate252 # pathvalidate # pathvalidate<3.0,>=2.4
		pip
		psutil598 # psutil # psutil<6.0,>=5.9
		pydantic # pydantic<3.0,>=2.0
		pydantic-core
		pyside6 # pyside6==6.7.2
		python-box610 # python-box # python-box[all]<7.0,>=6.0
		requests # requests<3.0,>=2.28
		ruamel-yaml
		ruamel-yaml-clib
		setuptools
		setuptools-scm
		shiboken6
		toml

		urllib3
		reusables096 # reusables<0.10.0,>=0.9.6
	];
	
	postInstall = ''
	mkdir -p $out/share/applications
	cat > $out/share/applications/fastflix.desktop << EOF
	[Desktop Entry]
	Name=FastFlix
	Comment=Transcoding assistant
	Exec=$out/bin/fastflix
	Icon=fastflix
	Terminal=true
	Type=Application
	Categories=AudioVideo;Video;Utility;
EOF

	install -Dm644 ${./resources/icon_16x16x32.png} $out/share/icons/hicolor/16x16/apps/fastflix.png
	install -Dm644 ${./resources/icon_32x32x32.png} $out/share/icons/hicolor/32x32/apps/fastflix.png
	install -Dm644 ${./resources/icon_64x64x32.png} $out/share/icons/hicolor/64x64/apps/fastflix.png
	install -Dm644 ${./resources/icon_128x128x32.png} $out/share/icons/hicolor/128x128/apps/fastflix.png
	install -Dm644 ${./resources/icon_256x256x32.png} $out/share/icons/hicolor/256x256/apps/fastflix.png
	install -Dm644 ${./resources/icon_512x512x32.png} $out/share/icons/hicolor/512x512/apps/fastflix.png
	install -Dm644 ${./resources/icon_1024x1024x32.png} $out/share/icons/hicolor/1024x1024/apps/fastflix.png
  '';

	meta = {
		homepage = "https://fastflix.org/";
		description = "Transcoding assistant.";
		longDescription = ''
			FastFlix is a free GUI for H.264, HEVC and AV1 hardware and software encoding!
		'';
		changelog = "https://github.com/cdgriffith/FastFlix/releases/tag/${version}";
		platforms = lib.platforms.linux;
	};
}
