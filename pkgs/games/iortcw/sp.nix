{
  lib,
  stdenv,
  fetchFromGitHub,
  opusfile,
  libogg,
  SDL2,
  openal,
  freetype,
  libjpeg,
  curl,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "iortcw-sp";
  version = "1.51c";

  src = fetchFromGitHub {
    owner = "iortcw";
    repo = "iortcw";
    tag = version;
    sha256 = "0g5wgqb1gm34pd05dj2i8nj3qhsz0831p3m7bsgxpjcg9c00jpyw";
  };

  enableParallelBuilding = true;

  sourceRoot = "${src.name}/SP";

  makeFlags = [
    "USE_INTERNAL_LIBS=0"
    "COPYDIR=${placeholder "out"}/opt/iortcw"
    "USE_OPENAL_DLOPEN=0"
    "USE_CURL_DLOPEN=0"
  ];

  installTargets = [ "copyfiles" ];

  buildInputs = [
    opusfile
    libogg
    SDL2
    freetype
    libjpeg
    openal
    curl
  ];
  nativeBuildInputs = [ makeWrapper ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-I${lib.getInclude SDL2}/include/SDL2"
    "-I${opusfile.dev}/include/opus"
  ];
  NIX_CFLAGS_LINK = [ "-lSDL2" ];

  postInstall = ''
    for i in `find $out/opt/iortcw -maxdepth 1 -type f -executable`; do
      makeWrapper $i $out/bin/`basename $i` --chdir "$out/opt/iortcw"
    done
  '';

  meta = with lib; {
    description = "Single player version of game engine for Return to Castle Wolfenstein";
    homepage = src.meta.homepage;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ rjpcasalino ];
  };
}
