{ fetchFromGitHub
, buildDotnetModule
}:

buildDotnetModule rec {
  pname = "CiderPress2";
  version = "1.0.6";

  src = fetchFromGitHub {
    owner = "fadden";
    repo = pname;
    rev = "v${version}";
    sha256 = "";
  };

  projectFile = "cp2/cp2.csproj";

  meta = with lib; {
    homepage = "https://github.com/fadden/CiderPress2/";
    description = "Tool for working with Apple II and vintage Mac disk images and file archives. ";
    license = licenses.asl20;
  };
}