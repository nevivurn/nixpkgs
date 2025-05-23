{
  lib,
  stdenv,
  fetchFromGitHub,
  linuxHeaders,
}:

stdenv.mkDerivation rec {
  pname = "linuxptp";
  version = "4.4";

  src = fetchFromGitHub {
    owner = "nwtime";
    repo = "linuxptp";
    tag = "v${version}";
    hash = "sha256-w1buo+D8Mnd6ytMhQYhvCDqt+RejlNSN/iVjrDR+Khk=";
  };

  outputs = [
    "out"
    "man"
  ];

  postPatch = ''
    substituteInPlace incdefs.sh --replace-fail \
       '/usr/include/linux/' "${linuxHeaders}/include/linux/"
  '';

  makeFlags = [
    "prefix="
    "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
  ];

  preInstall = ''
    export DESTDIR=$out
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Implementation of the Precision Time Protocol (PTP) according to IEEE standard 1588 for Linux";
    homepage = "https://linuxptp.nwtime.org";
    maintainers = [ maintainers.markuskowa ];
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
