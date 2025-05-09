{
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
}:

stdenv.mkDerivation rec {
  pname = "bgpq4";
  version = "1.15";

  src = fetchFromGitHub {
    owner = "bgp";
    repo = "bgpq4";
    tag = version;
    sha256 = "sha256-3mfFj9KoQbDe0gH7Le03N1Yds/bTEmY+OiXNaOtHkpY=";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  meta = with lib; {
    description = "BGP filtering automation tool";
    homepage = "https://github.com/bgp/bgpq4";
    license = licenses.bsd2;
    maintainers = with maintainers; [ vincentbernat ];
    platforms = with platforms; unix;
    mainProgram = "bgpq4";
  };
}
