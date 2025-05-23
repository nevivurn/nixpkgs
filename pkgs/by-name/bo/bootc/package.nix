{
  lib,
  rustPlatform,
  fetchFromGitHub,
  libz,
  zstd,
  pkg-config,
  openssl,
  glib,
  ostree-full,
  versionCheckHook,
}:

rustPlatform.buildRustPackage rec {
  pname = "bootc";
  version = "1.1.2";
  useFetchCargoVendor = true;
  cargoHash = "sha256-/Sb2XtVguj5zpj/OTl90xFHFSaBeLgb8xIlNm4UrnRI=";
  doInstallCheck = true;

  src = fetchFromGitHub {
    owner = "containers";
    repo = "bootc";
    tag = "v${version}";
    hash = "sha256-p1+j62MllmPcvWnijieSZmlgwYy76X17fv12Haetz78=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    libz
    zstd
    openssl
    glib
    ostree-full
  ];

  nativeInstallCheckInputs = [
    versionCheckHook
  ];

  meta = {
    description = "Boot and upgrade via container images";
    homepage = "https://containers.github.io/bootc";
    license = lib.licenses.mit;
    mainProgram = "bootc";
    maintainers = with lib.maintainers; [ thesola10 ];
    platforms = lib.platforms.linux;
  };
}
