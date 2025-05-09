{
  lib,
  stdenv,
  fetchFromGitHub,
  git,
  perl,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "git-octopus";
  version = "1.4";

  installFlags = [ "prefix=$(out)" ];

  nativeBuildInputs = [ makeWrapper ];

  # perl provides shasum
  postInstall = ''
    for f in $out/bin/*; do
      wrapProgram $f --prefix PATH : ${
        lib.makeBinPath [
          git
          perl
        ]
      }
    done
  '';

  src = fetchFromGitHub {
    owner = "lesfurets";
    repo = "git-octopus";
    tag = "v${version}";
    sha256 = "14p61xk7jankp6gc26xciag9fnvm7r9vcbhclcy23f4ghf4q4sj1";
  };

  meta = with lib; {
    homepage = "https://github.com/lesfurets/git-octopus";
    description = "Continuous merge workflow";
    license = licenses.lgpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.mic92 ];
  };
}
