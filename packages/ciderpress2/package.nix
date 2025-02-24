{ stdenv
, lib
, fetchFromGitHub
, buildDotnetModule
, dotnetCorePackages
}:

buildDotnetModule rec {
	pname = "CiderPress2";
	version = "1.0.7-dev1";

	src = fetchFromGitHub {
		owner = "dsaul";
		repo = pname;
		rev = "813a4aaa3ac6976428a78c44ccca15e51c5dd4e8";
		sha256 = "sha256-R3yNLS0vdPAT4g08I31MjbTat06FvOtRiddnl6+nJVE=";
	};

	projectFile = "cp2/cp2.csproj";
	dotnet-sdk = dotnetCorePackages.sdk_8_0;
	dotnet-runtime = dotnetCorePackages.runtime_8_0;
	nugetDeps = ./deps.nix; # create a blank file here, then populate it with `nix-build -A fetch-deps && ./result`
	
	executables = [ "cp2" ];
	dontRestoreNugetDeps = true;
	
	meta = with lib; {
		homepage = "https://github.com/fadden/CiderPress2/";
		description = "Tool for working with Apple II and vintage Mac disk images and file archives. ";
		license = licenses.asl20;
	};
}