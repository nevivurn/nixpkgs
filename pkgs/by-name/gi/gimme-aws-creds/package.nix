{
  lib,
  installShellFiles,
  python3,
  fetchFromGitHub,
  nix-update-script,
  testers,
  gimme-aws-creds,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "gimme-aws-creds";
  version = "2.8.2"; # N.B: if you change this, check if overrides are still up-to-date
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "Nike-Inc";
    repo = "gimme-aws-creds";
    tag = "v${version}";
    hash = "sha256-fsFYcfbLeYV6tpOGgNrFmYjcUAmdsx5zwUbvcctwFVs=";
  };

  nativeBuildInputs = with python3.pkgs; [
    installShellFiles
  ];

  pythonRemoveDeps = [
    "configparser"
  ];

  dependencies = with python3.pkgs; [
    boto3
    beautifulsoup4
    ctap-keyring-device
    requests
    okta
    pyjwt
    html5lib
    furl
  ];

  preCheck = ''
    # Disable using platform's keyring unavailable in sandbox
    export PYTHON_KEYRING_BACKEND="keyring.backends.fail.Keyring"
  '';

  nativeCheckInputs = with python3.pkgs; [
    pytestCheckHook
    responses
  ];

  disabledTests = [
    "test_build_factor_name_webauthn_registered"
  ];

  pythonImportsCheck = [
    "gimme_aws_creds"
  ];

  postInstall = ''
    rm $out/bin/gimme-aws-creds.cmd
    chmod +x $out/bin/gimme-aws-creds
    installShellCompletion --bash --name gimme-aws-creds $out/bin/gimme-aws-creds-autocomplete.sh
    rm $out/bin/gimme-aws-creds-autocomplete.sh
  '';

  passthru = {
    updateScript = nix-update-script { };
    tests.version = testers.testVersion {
      package = gimme-aws-creds;
      command = ''touch tmp.conf && OKTA_CONFIG="tmp.conf" gimme-aws-creds --version'';
      version = "gimme-aws-creds ${version}";
    };
  };

  meta = with lib; {
    homepage = "https://github.com/Nike-Inc/gimme-aws-creds";
    changelog = "https://github.com/Nike-Inc/gimme-aws-creds/releases";
    description = "CLI that utilizes Okta IdP via SAML to acquire temporary AWS credentials";
    mainProgram = "gimme-aws-creds";
    license = licenses.asl20;
    maintainers = with maintainers; [ jbgosselin ];
  };
}
