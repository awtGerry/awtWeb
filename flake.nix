{
  description = "Nix flakes to develop with rust (zola)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs =
    {
      nixpkgs,
      flake-utils,
      rust-overlay,
      treefmt-nix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rust-overlay.overlays.default
          ];
        };
        treefmtEval = treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs = {
            nixpkgs-fmt.enable = true;
            rustfmt.enable = true;
          };
        };
        packages = with pkgs; [
          treefmtEval.config.build.wrapper
          zola
          rust-bin.stable.latest.default # don't need anything beyond stable
        ];
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = packages;
          shellHook = ''
            echo "You are now on nix shell ❄️"
            echo "Tip: Use 'nix fmt' to format the code"
          '';
        };
        formatter = treefmtEval.config.build.wrapper;
      }
    );
}
