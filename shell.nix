let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in pkgs.callPackage ./default.nix {
  path = ./.;
  dev-shell = true;
}
