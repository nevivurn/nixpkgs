{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "brev-cli";
  version = "0.6.308";

  src = fetchFromGitHub {
    owner = "brevdev";
    repo = pname;
    tag = "v${version}";
    sha256 = "sha256-gqx/aOTpoN7nfstlFl4EulQ9Kzm/YlYOOiyrWIoJvcU=";
  };

  vendorHash = "sha256-DMkBRya1Dxn8mcpuG/vtIt+v/9iVmb58iNe3fPY/xv4=";

  env.CGO_ENABLED = 0;
  subPackages = [ "." ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/brevdev/brev-cli/pkg/cmd/version.Version=${src.rev}"
  ];

  postInstall = ''
    mv $out/bin/brev-cli $out/bin/brev
  '';

  meta = with lib; {
    description = "Connect your laptop to cloud computers";
    mainProgram = "brev";
    homepage = "https://github.com/brevdev/brev-cli";
    changelog = "https://github.com/brevdev/brev-cli/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ dit7ya ];
  };
}
