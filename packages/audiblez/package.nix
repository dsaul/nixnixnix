{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, setuptools
}:

buildPythonPackage rec {
  pname = "audiblez";
  version = "0.4.4";
  format = "pyproject";
  doCheck = false;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-DWJxK5VrwVT4X7CiZuKjxZE8KWfgA0hwGzJBHW3vMeU=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  nativeCheckInputs = [
	
  ];

  doCheck = false;

  meta = with lib; {
    changelog = "https://pypi.org/project/audiblez/${version}/";
    description = "Generate audiobooks from e-books";
    homepage = "https://github.com/santinic/audiblez";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}
