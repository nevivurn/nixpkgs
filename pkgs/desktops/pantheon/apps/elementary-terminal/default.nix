{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
  pkg-config,
  meson,
  ninja,
  vala,
  desktop-file-utils,
  gtk3,
  granite,
  libhandy,
  libnotify,
  vte,
  libgee,
  pcre2,
  wrapGAppsHook3,
  xvfb-run,
}:

stdenv.mkDerivation rec {
  pname = "elementary-terminal";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = "terminal";
    tag = version;
    sha256 = "sha256-2Z56U6nbqwlbrSMzTYv7cSI7LT7pvDhW0w4f3wxv6ZA=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pkg-config
    vala
    wrapGAppsHook3
    xvfb-run
  ];

  buildInputs = [
    granite
    gtk3
    libgee
    libhandy
    libnotify
    pcre2
    vte
  ];

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "Terminal emulator designed for elementary OS";
    longDescription = ''
      A super lightweight, beautiful, and simple terminal. Comes with sane defaults, browser-class tabs, sudo paste protection,
      smart copy/paste, and little to no configuration.
    '';
    homepage = "https://github.com/elementary/terminal";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = teams.pantheon.members;
    mainProgram = "io.elementary.terminal";
  };
}
