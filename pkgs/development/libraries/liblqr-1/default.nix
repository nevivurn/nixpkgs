{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  glib,
  Carbon,
  AppKit,
}:

stdenv.mkDerivation rec {
  pname = "liblqr-1";
  version = "0.4.2";

  outputs = [
    "out"
    "dev"
  ];

  src = fetchFromGitHub {
    owner = "carlobaldassi";
    repo = "liblqr";
    tag = "v${version}";
    sha256 = "10mrl5k3l2hxjhz4w93n50xwywp6y890rw2vsjcgai8627x5f1df";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [
    Carbon
    AppKit
  ];
  propagatedBuildInputs = [ glib ];

  meta = with lib; {
    homepage = "http://liblqr.wikidot.com";
    description = "Seam-carving C/C++ library called Liquid Rescaling";
    platforms = platforms.all;
    license = with licenses; [
      gpl3
      lgpl3
    ];
  };
}
