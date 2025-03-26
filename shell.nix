let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
pkgs.mkShell {
  packages = with pkgs; [
    go
    wlroots_0_18
    libinput
    libxkbcommon
    pkg-config
    xorg.libxcb
    xwayland
    wayland
    wayland-protocols
    wayland-scanner
    xorg.xcbutilwm
    pixman
    clang
  ];
}
