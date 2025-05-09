{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  glib,
  dbus,
  openssl_3,
}:
rustPlatform.buildRustPackage rec {
  pname = "cwe-client-cli";
  version = "0.3.2";
  src = fetchFromGitHub {
    owner = "NotBalds";
    repo = "cwe-client-cli";
    tag = "v${version}";
    hash = "sha256-7zzmYwuQ+Sg8hf1zuKtKUMgk0Is1YJB4WdOKdxtWRA0=";
  };
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    glib
    dbus
    openssl_3
  ];
  useFetchCargoVendor = true;
  cargoHash = "sha256-ctcsO7HRs3wWcOFW+ewQbKGCSEBlVzT/enAEjFIAaPU=";

  meta = {
    description = "Simple command line client for CWE";
    homepage = "https://github.com/NotBalds/cwe-client-cli";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ tbwanderer ];
    mainProgram = "cwe-client-cli";
    platforms = lib.platforms.linux;
  };
}
