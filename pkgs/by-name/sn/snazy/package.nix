{
  lib,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  stdenv,
}:

rustPlatform.buildRustPackage rec {
  pname = "snazy";
  version = "0.55.0";

  src = fetchFromGitHub {
    owner = "chmouel";
    repo = pname;
    tag = version;
    hash = "sha256-Vc3L93S7WQAcqsLIhiCrTGmmc+1q26zRpOWXyUNFNVc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-ZieQfjRSxO5LEpQaXFIPcdejoG+6Mw4FCM/7LcbwRro=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd snazy \
      --bash <($out/bin/snazy --shell-completion bash) \
      --fish <($out/bin/snazy --shell-completion fish) \
      --zsh <($out/bin/snazy --shell-completion zsh)
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/snazy --help
    $out/bin/snazy --version | grep "snazy ${version}"
    runHook postInstallCheck
  '';

  meta = with lib; {
    description = "Snazzy json log viewer";
    mainProgram = "snazy";
    longDescription = ''
      Snazy is a simple tool to parse json logs and output them in a nice format
      with nice colors.
    '';
    homepage = "https://github.com/chmouel/snazy/";
    changelog = "https://github.com/chmouel/snazy/releases/tag/${src.rev}";
    license = licenses.asl20;
    maintainers = with maintainers; [
      figsoda
      jk
    ];
  };
}
