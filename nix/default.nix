{ sources ? import ./sources.nix }:
with
  { overlay = _: pkgs:
      { inherit (import sources.niv {}) niv;
        hie-core-src = "${sources.daml}/compiler/hie-core";
        haskellnix = import sources."haskell.nix" {};
        packages = pkgs.callPackages ./packages.nix {};
      };
  };
import sources.nixpkgs
  { overlays = [ overlay ] ; config = {}; }
