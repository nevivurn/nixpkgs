{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "pacparser";
  version = "1.4.5";

  src = fetchFromGitHub {
    owner = "manugarg";
    repo = "pacparser";
    tag = "v${version}";
    sha256 = "sha256-X842+xPjM404aQJTc2JwqU4vq8kgyKhpnqVu70pNLks=";
  };

  makeFlags = [
    "NO_INTERNET=1"
    "PREFIX=${placeholder "out"}"
  ];

  preConfigure = ''
    patchShebangs tests/runtests.sh
    cd src
  '';

  hardeningDisable = [ "format" ];

  meta = {
    description = "Library to parse proxy auto-config (PAC) files";
    homepage = "https://pacparser.manugarg.com/";
    license = lib.licenses.lgpl3;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ abbradar ];
    mainProgram = "pactester";
  };
}
