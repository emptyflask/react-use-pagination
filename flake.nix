{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, ... }@inputs:
    with inputs.flake-utils.lib;
    eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };

      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              biome
              corepack_20
              nodejs
              (with nodePackages; [ typescript typescript-language-server ])
            ];
          };
        };
      });
}
