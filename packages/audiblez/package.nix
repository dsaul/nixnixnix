{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "audiblez";
  version = "0.4.4";
  format = "pyproject";
  doCheck = false;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-oYeE+hFpuKh7zkrAG48voxMYdkpu70lwtSOgjU5dUvw=";
  };

  nativeBuildInputs = [
    setuptools
	
  ];
  
  buildInputs = [
	wheel
  ];

  nativeCheckInputs = [
	
  ];

  meta = with lib; {
    changelog = "https://pypi.org/project/audiblez/${version}/";
    description = "Generate audiobooks from e-books";
    homepage = "https://github.com/santinic/audiblez";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}
