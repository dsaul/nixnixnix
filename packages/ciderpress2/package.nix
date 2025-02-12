{ stdenv
, lib
, fetchFromGitHub
, buildDotnetModule
, dotnetCorePackages
}:

buildDotnetModule rec {
	pname = "CiderPress2";
	version = "1.0.6";

	src = fetchFromGitHub {
		owner = "fadden";
		repo = pname;
		rev = "v${version}";
		sha256 = "sha256-pRvOu3bXTaFkwbwniL5qpZXdDLodgr+PD5I6jQOWvPM=";
	};

	projectFile = "cp2/cp2.csproj";
	dotnet-sdk = dotnetCorePackages.sdk_8_0;
	dotnet-runtime = dotnetCorePackages.runtime_8_0;
	nugetDeps = ./deps.nix; # create a blank file here, then populate it with `nix-build -A fetch-deps && ./result`
	
	meta = with lib; {
		homepage = "https://github.com/fadden/CiderPress2/";
		description = "Tool for working with Apple II and vintage Mac disk images and file archives. ";
		license = licenses.asl20;
	};
}