{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  dbus-python,
  pygobject3,
}:

buildPythonPackage rec {
  pname = "gatt";
  version = "0.2.6";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "getsenic";
    repo = "gatt-python";
    tag = version;
    hash = "sha256-GMLqQ9ojQ649hbbJB+KiQoOhiTWweOgv6zaCDzhIB5A=";
  };

  propagatedBuildInputs = [
    dbus-python
    pygobject3
  ];

  pythonImportsCheck = [ "gatt" ];

  meta = with lib; {
    description = "Bluetooth (Generic Attribute Profile) GATT SDK for Python";
    mainProgram = "gattctl";
    homepage = "https://github.com/getsenic/gatt-python/";
    license = licenses.mit;
    maintainers = [ ];
  };
}
