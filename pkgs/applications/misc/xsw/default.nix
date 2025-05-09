{
  stdenv,
  lib,
  fetchFromGitHub,
  pkg-config,
  SDL,
  SDL_image,
  SDL_ttf,
  SDL_gfx,
  flex,
  bison,
}:

let
  makeSDLFlags = map (p: "-I${lib.getDev p}/include/SDL");

in
stdenv.mkDerivation rec {
  pname = "xsw";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "andrenho";
    repo = "xsw";
    tag = version;
    sha256 = "092vp61ngd2vscsvyisi7dv6qrk5m1i81gg19hyfl5qvjq5p0p8g";
  };

  nativeBuildInputs = [
    pkg-config
    flex
    bison
  ];

  buildInputs = [
    SDL
    SDL_image
    SDL_ttf
    SDL_gfx
  ];

  env.NIX_CFLAGS_COMPILE =
    toString (makeSDLFlags [
      SDL
      SDL_image
      SDL_ttf
      SDL_gfx
    ])
    + " -lSDL";

  patches = [
    ./parse.patch # Fixes compilation error by avoiding redundant definitions.
    ./sdl-error.patch # Adds required include for SDL_GetError.
  ];

  meta = with lib; {
    inherit (src.meta) homepage;
    description = "Slide show presentation tool";

    platforms = platforms.unix;
    license = licenses.gpl3;
    maintainers = [ ];
    mainProgram = "xsw";
  };
}
