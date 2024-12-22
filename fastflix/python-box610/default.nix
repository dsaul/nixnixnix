{ lib
, buildPythonPackage
, fetchFromGitHub
, msgpack
, pytestCheckHook
, pyyaml
, ruamel-yaml
, toml
, tomli
, tomli-w
, cython
}:

buildPythonPackage rec {
  pname = "python-box";
  version = "6.1.0";
  format = "setuptools";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "cdgriffith";
    repo = "Box";
    rev = "refs/tags/${version}";
    hash = "sha256-42VDZ4aASFFWhRY3ApBQ4dq76eD1flZtxUM9hpA9iiI=";
  };

  passthru.optional-dependencies = {
    all = [
      msgpack
      ruamel-yaml
      toml
      cython
    ];
    yaml = [
      ruamel-yaml
    ];
    ruamel-yaml = [
      ruamel-yaml
    ];
    PyYAML = [
      pyyaml
    ];
    tomli = [
      tomli-w
      tomli
    ];
    toml = [
      toml
    ];
    msgpack = [
      msgpack
    ];
  };

  nativeCheckInputs = [
    pytestCheckHook
  ] ++ passthru.optional-dependencies.all;

  pythonImportsCheck = [
    "box"
  ];

  meta = with lib; {
    description = "Python dictionaries with advanced dot notation access";
    homepage = "https://github.com/cdgriffith/Box";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
