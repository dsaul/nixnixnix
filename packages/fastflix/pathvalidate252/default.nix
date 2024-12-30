{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "pathvalidate";
  version = "2.5.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-X/V9D6vl7Lek8eSVe/61rYq1q0wPpx95xrvCS9m30U0=";
  };

  # Requires `pytest-md-report`, causing infinite recursion.
  doCheck = false;

  pythonImportsCheck = [
    "pathvalidate"
  ];

  meta = with lib; {
    description = "Library to sanitize/validate a string such as filenames/file-paths/etc";
    homepage = "https://github.com/thombashi/pathvalidate";
    changelog = "https://github.com/thombashi/pathvalidate/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ oxalica ];
  };
}
