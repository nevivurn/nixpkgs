{
  lib,
  rustPlatform,
  fetchFromGitHub,
  testers,
  pik,
}:

rustPlatform.buildRustPackage rec {
  pname = "pik";
  version = "0.19.0";

  src = fetchFromGitHub {
    owner = "jacek-kurlit";
    repo = "pik";
    tag = version;
    hash = "sha256-G4GTrS3zUQVLsdc/19qPl4GWZZe4U8jV+UOkX36fMWU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-T8kgWjmmffPFewtp+5g15RoNXCoQH5bliTukM26JnlI=";

  passthru.tests.version = testers.testVersion { package = pik; };

  meta = {
    description = "Process Interactive Kill";
    longDescription = ''
      Process Interactive Kill is a command line tool that helps to find and kill process.
      It works like pkill command but search is interactive.
    '';
    homepage = "https://github.com/jacek-kurlit/pik";
    license = with lib.licenses; [ mit ];
    maintainers = with lib.maintainers; [ bew ];
    mainProgram = "pik";
  };
}
