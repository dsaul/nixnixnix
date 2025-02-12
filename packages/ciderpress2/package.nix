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
		owner = "dsaul";
		repo = pname;
		rev = "316573e366b60fa2a998a325703bb8630728879b";
		sha256 = "sha256-aE6KPUBHu7tkbMRVpf302rW5hn2LiiukWhqEQNa/fd4=";
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