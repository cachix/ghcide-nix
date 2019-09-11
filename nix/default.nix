{ sources ? import ./sources.nix }:
with
  { overlay = _: pkgs:
    let
      haskellnix = import sources."haskell.nix" { inherit pkgs; };
      mkHieCore = ghc:
        let
          pkgSet = haskellnix.mkStackPkgSet {
            stack-pkgs = import ./stack/pkgs.nix;
            pkg-def-extras = [];
            modules = [
              { packages.Cabal.patches = [./cabal.patch]; }
              { packages.happy.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
              { packages.pretty-show.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
              { packages.hie-core.src = "${sources.daml}/compiler/hie-core"; }
              { ghc.package = ghc; }
              { nonReinstallablePkgs = ["ghc-boot" "binary" "process" "bytestring" "containers" "directory" 
                   "filepath" "hpc" "ghci" "terminfo" "time" "transformers" "unix" "text"]
                ++ pkgs.lib.optionals (ghc.version == "8.8.1") [ "contravariant" ];
              }
            ];
          };
          packages = pkgSet.config.hsPkgs;
        in packages.hie-core.components.exes.hie-core;
    in { export = {
          # hie-core-ghc881 = mkHieCore pkgs.haskell.compiler.ghc881;
          hie-core-ghc865 = mkHieCore pkgs.haskell.compiler.ghc865;
          hie-core-ghc864 = mkHieCore pkgs.haskell.compiler.ghc864;
          # hie-core-ghc844 = mkHieCore pkgs.haskell.compiler.ghc844;
         };
         devTools = {
           inherit (import sources.niv {}) niv;
           inherit (haskellnix) nix-tools;
         };
      };
  };
import sources.nixpkgs
  { overlays = [ overlay ] ; config = {}; }
