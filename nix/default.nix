{ sources ? import ./sources.nix }:
with
  { overlay = _: pkgs:
    let
      haskellnix = import sources."haskell.nix" { inherit pkgs; };
      mkHieCore =
        let
          pkgSet = haskellnix.mkStackPkgSet {
            stack-pkgs = import ./stack/pkgs.nix;
            pkg-def-extras = [];
            modules = [
              { packages.Cabal.patches = [./cabal.patch]; }
              { packages.happy.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
              { packages.pretty-show.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
              { packages.hie-core.src = "${sources.daml}/compiler/hie-core"; }
              { nonReinstallablePkgs = ["ghc-boot" "binary" "process" "bytestring" "containers" "directory" "filepath" "hpc" "ghci" "terminfo" "time" "transformers" "unix"]; }
            ];
          };
          packages = pkgSet.config.hsPkgs;
        in packages.hie-core.components.exes.hie-core;
    in { 
        inherit (import sources.niv {}) niv;
        hie-core-ghc865 = mkHieCore;
      };
  };
import sources.nixpkgs
  { overlays = [ overlay ] ; config = {}; }
