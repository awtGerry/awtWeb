{
  description = "Flake to run gleam lustre projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

      packages = with pkgs; [
        gleam
        # erlang # Currently broke `rebar3` dependency
        erlang_26
        inotify-tools
        esbuild
        rebar3
      ];
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = packages;

        shellHook = ''
          echo "You are now in a nix shell ❄️"
          echo -e "You can now start the project with \033[0;34m gleam run -m lustre/dev start"
        '';
      };
    });
}
