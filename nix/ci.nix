let
  sources = import ./sources.nix;
  inherit (import ./dimension.nix { lib = import (sources.nixpkgs + "/lib"); })
    dimension
    ;

in
  dimension "System" {
    "x86_64-linux" = {};
    # "x86_64-darwin" = {};
  } (system: {}:

    dimension "Nixpkgs release" {
      "nixpkgs-19_03".nixpkgs = sources.nixpkgs;
      # "nixpkgs-19_09".nixpkgs = sources."nixos-19.09";
    } (_nixpkgsRelease: { nixpkgs }:

      import ../default.nix {
        pkgs = import ./default.nix { inherit system; };
      }

    )
  )
