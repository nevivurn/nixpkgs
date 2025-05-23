{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  Security,
  testers,
  igrep,
}:

rustPlatform.buildRustPackage rec {
  pname = "igrep";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "konradsz";
    repo = "igrep";
    tag = "v${version}";
    hash = "sha256-ZZhzBGLpzd9+rok+S/ypKpWXVzXaA1CnviC7LfgP/CU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-NZN9pB9McZkTlpGgAbxi8bwn+aRiPMymGmBLYBc6bmw=";

  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [ Security ];

  passthru.tests = {
    version = testers.testVersion {
      package = igrep;
      command = "ig --version";
    };
  };

  meta = with lib; {
    description = "Interactive Grep";
    homepage = "https://github.com/konradsz/igrep";
    changelog = "https://github.com/konradsz/igrep/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ _0x4A6F ];
    mainProgram = "ig";
  };
}
