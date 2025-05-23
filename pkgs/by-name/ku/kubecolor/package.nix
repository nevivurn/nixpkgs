{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  kubectl,
  installShellFiles,
}:

buildGoModule rec {
  pname = "kubecolor";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "kubecolor";
    repo = "kubecolor";
    tag = "v${version}";
    sha256 = "sha256-Q3Bl1ejuSpiMpQgiqKa2x/g02hNx326GM2MIDoi7q7o=";
  };

  vendorHash = "sha256-SWJbJ/zr9ygZYUuH8QNvgmUXdxb/3OViai48CFmWmXw=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  subPackages = [
    "."
  ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    # kubecolor re-uses the completions of kubectl for its own executable

    installShellCompletion --cmd kubecolor \
      --bash <(${lib.getExe kubectl} completion bash) \
      --fish <(${lib.getExe kubectl} completion fish) \
      --zsh <(${lib.getExe kubectl} completion zsh)

    # https://kubecolor.github.io/setup/shells/bash/
    echo 'complete -o default -F __start_kubectl kubecolor' >> $out/share/bash-completion/completions/kubecolor.bash

    # https://kubecolor.github.io/setup/shells/fish/
    echo -e 'function kubecolor --wraps kubectl\n  command kubecolor $argv\nend' >> $out/share/fish/vendor_completions.d/kubecolor.fish

    # https://kubecolor.github.io/setup/shells/zsh/
    echo 'compdef kubecolor=kubectl' >> $out/share/zsh/site-functions/_kubecolor
  '';

  meta = with lib; {
    description = "Colorizes kubectl output";
    mainProgram = "kubecolor";
    homepage = "https://github.com/kubecolor/kubecolor";
    changelog = "https://github.com/kubecolor/kubecolor/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [
      ivankovnatsky
      SuperSandro2000
      applejag
    ];
  };
}
