{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "statik";
  version = "0.1.7";

  src = fetchFromGitHub {
    owner = "rakyll";
    repo = "statik";
    tag = "v${version}";
    sha256 = "ahsNiac/3I2+PUqc90E73Brb99M68ewh9nWXoupfE3g=";
  };

  vendorHash = null;

  # Avoid building example
  subPackages = [
    "."
    "fs"
  ];
  # Tests are checking that the files embedded are preserving
  # their meta data like dates etc, but it assumes to be in 2048
  # which is not the case once entered the nix store
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/rakyll/statik";
    description = "Embed files into a Go executable";
    mainProgram = "statik";
    license = licenses.asl20;
    maintainers = with maintainers; [ Madouura ];
  };
}
