{
  description = "A flake package for my dwl config";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs }:
    let

      # to work with older version of flakes
      lastModifiedDate =
        self.lastModifiedDate or self.lastModified or "19700101";

      # Generate a user-friendly version number.
      version = self.rev;

      # System types to support.
      supportedSystems = [ "x86_64-linux" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        });

    in {

      # A Nixpkgs overlay.
      overlay = final: prev: {

        dwl = with final;
          stdenv.mkDerivation rec {
            pname = "dwl";
            inherit version;

            src = ./.;

            nativeBuildInputs = [ autoreconfHook ];
          };

      };

      # Provide some binary packages for selected system types.
      packages =
        forAllSystems (system: { inherit (nixpkgsFor.${system}) dwl; });

      # The default package for 'nix build'. This makes sense if the
      # flake provides only one package or there is a clear "main"
      # package.
      defaultPackage = forAllSystems (system: self.packages.${system}.dwl);

      # Tests run by 'nix flake check' and by Hydra.

    };
}
