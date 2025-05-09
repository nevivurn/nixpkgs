{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  gdal,
  openssl,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "t-rex";
  version = "0.15.0-alpha3";

  src = fetchFromGitHub {
    owner = "t-rex-tileserver";
    repo = "t-rex";
    tag = "v${version}";
    hash = "sha256-oZZrR86/acoyMX3vC1JGrpc8G+DEuplqfEAnaP+TBGU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-z0YpX1dMWcn2N6fKDbT7lYEQC5PaDNNHi4CW88d/dgI=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    gdal
    openssl
  ] ++ lib.optional stdenv.hostPlatform.isDarwin darwin.apple_sdk.frameworks.Security;

  meta = with lib; {
    description = "Vector tile server specialized on publishing MVT tiles";
    homepage = "https://t-rex.tileserver.ch/";
    changelog = "https://github.com/t-rex-tileserver/t-rex/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = teams.geospatial.members;
    mainProgram = "t_rex";
    platforms = platforms.unix;
    broken = true; # see https://github.com/t-rex-tileserver/t-rex/issues/320
  };
}
