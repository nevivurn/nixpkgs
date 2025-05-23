{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation rec {
  pname = "cmark";
  version = "0.31.1";

  src = fetchFromGitHub {
    owner = "commonmark";
    repo = "cmark";
    tag = version;
    sha256 = "sha256-+JLw7zCjjozjq1RhRQGFqHj/MTUTq3t7A0V3T2U2PQk=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags =
    # Link the executable with the shared library on system with shared libraries.
    lib.optional (!stdenv.hostPlatform.isStatic) "-DCMARK_STATIC=OFF"
    # Do not attempt to build .so library on static platform.
    ++ lib.optional stdenv.hostPlatform.isStatic "-DCMARK_SHARED=OFF";

  doCheck = true;

  preCheck =
    let
      lib_path = if stdenv.hostPlatform.isDarwin then "DYLD_FALLBACK_LIBRARY_PATH" else "LD_LIBRARY_PATH";
    in
    ''
      export ${lib_path}=$(readlink -f ./src)
    '';

  meta = with lib; {
    description = "CommonMark parsing and rendering library and program in C";
    mainProgram = "cmark";
    homepage = "https://github.com/commonmark/cmark";
    changelog = "https://github.com/commonmark/cmark/raw/${version}/changelog.txt";
    maintainers = [ maintainers.michelk ];
    platforms = platforms.all;
    license = licenses.bsd2;
  };
}
