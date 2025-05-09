{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "tar2ext4";
  version = "0.12.8";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "hcsshim";
    tag = "v${version}";
    sha256 = "sha256-20+y7wFV3HxkrS1qHNq2neIc826HU5AXzuqqS7Ll2gg=";
  };

  sourceRoot = "${src.name}/cmd/tar2ext4";
  vendorHash = null;

  meta = with lib; {
    description = "Convert a tar archive to an ext4 image";
    maintainers = with maintainers; [ qyliss ];
    license = licenses.mit;
    mainProgram = "tar2ext4";
  };
}
