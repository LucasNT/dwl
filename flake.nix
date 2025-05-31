{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.dwl =
        pkgs.callPackage ./default.nix { path = "${self}"; };
      devShell.x86_64-linux = pkgs.callPackage ./default.nix {
        path = "${self}";
        dev-shell = true;
      };
      packages.x86_64-linux.default = self.packages.x86_64-linux.dwl;

    };

}
