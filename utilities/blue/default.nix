{ lib
, buildPythonPackage
, fetchPypi
, hypothesis
, pytestCheckHook
, setuptools
}:

buildPythonPackage rec {
  pname = "blue";
  version = "0.9.1 ";
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
    hypothesis
    pytestCheckHook
  ];
  pythonImportsCheck = [ "chardet" ];

  
}
