# default.nix
{ stdenv, lib, path, wlroots_0_18, libinput, libxkbcommon, pkg-config, xorg
, xwayland, wayland, wayland-protocols, wayland-scanner, pixman, libX11
, installShellFiles, dev-shell ? false, clang }:

stdenv.mkDerivation {
  pname = "dwl-lucasnt";
  version = "v0.7.2";

  src = path;

  buildInputs = [
    libinput
    libX11
    libxkbcommon
    pixman
    pkg-config
    wayland
    wayland-protocols
    wayland-scanner
    wlroots_0_18
    xorg.libxcb
    xorg.xcbutilwm
    xwayland
  ] ++ lib.optionals dev-shell [ clang ];

  nativeBuildInputs = [ installShellFiles pkg-config wayland-scanner ];

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
    "WAYLAND_SCANNER=wayland-scanner"
    "PREFIX=$(out)"
    "MANDIR=$(man)/share/man"
    "DATADIR=$(out)/share"
    ''XLIBS=" xcb xcb-icccm"''
    "XWAYLAND=-DXWAYLAND"
  ];

  __structuredAttrs = true;

  outputs = [ "out" "man" ];

}
