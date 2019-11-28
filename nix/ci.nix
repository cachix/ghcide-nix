let
  sources = import ./sources.nix;
  inherit (import ./dimension.nix { lib = import (sources.nixpkgs + "/lib"); })
    dimension
    ;

in
  dimension "System" {
    "x86_64-linux" = {};
    "x86_64-darwin" = {};
  } (system: {}:

    import ../default.nix {
      pkgs = import ./default.nix { inherit system; };
    }

  )
