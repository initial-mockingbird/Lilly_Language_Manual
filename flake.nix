{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [];

      perSystem = { self', pkgs, config, ... }: {

        devShells.default = pkgs.mkShell {
          name = "typst-template";
          meta.description = "Typst development environment";
          inputsFrom = [
          ];
          nativeBuildInputs =
            [ pkgs.mdbook
              pkgs.just
              pkgs.zip
            ];
        };
      };
    };
}
