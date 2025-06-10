{
  description = "Python Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        nativeBuildInputs = with pkgs; [
          (
            pkgs.texliveFull.withPackages
            (ps:
              with ps; [
                latexmk
                amsmath
                marvosym
                bbm-macros
                minted
                texcount
                tocbibind
                latexindent
                adjustbox
                algpseudocodex
                algorithmicx
                algorithms
                fifo-stack
                varwidth
                tabto-ltx
                totcount
              ])
          )
        ];

        buildInputs = with pkgs; [];
      in {
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};
      }
    );
}
