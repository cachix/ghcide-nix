{ sources ? import ./sources.nix, system ? builtins.currentSystem }:
with
  { overlay = _: pkgs:
    let
      haskellnix = import sources."haskell.nix" { inherit pkgs; };
      mkHieCore = ghc:
        let
          pkgSet = haskellnix.mkStackPkgSet {
            stack-pkgs = import ./stack/pkgs.nix;
            pkg-def-extras = [];
            modules = [{
                packages.ghcide.src = sources.ghcide;
                ghc.package = ghc; 
                compiler.version = pkgs.lib.mkForce ghc.version;
                nonReinstallablePkgs = ["ghc-boot" "binary" "process" "bytestring" "containers" "directory" 
                   "filepath" "hpc" "ghci" "terminfo" "time" "transformers" "unix" "text"]
                ++ pkgs.lib.optionals (ghc.version == "8.8.1") [ "contravariant" ];
            }];
          };
          packages = pkgSet.config.hsPkgs;
        in packages.ghcide.components.exes.ghcide;
    in { export = {
          # ghcide-ghc881 = mkHieCore pkgs.haskell.compiler.ghc881;
          ghcide-ghc865 = mkHieCore pkgs.haskell.compiler.ghc865;
          ghcide-ghc864 = mkHieCore pkgs.haskell.compiler.ghc864;
          ghcide-ghc844 = mkHieCore pkgs.haskell.compiler.ghc844;
         };

         devTools = {
           inherit (import sources.niv {}) niv;
           inherit (haskellnix) nix-tools;
         };
         inherit haskellnix;
      };
  };
import sources.nixpkgs
  { overlays = [ overlay ] ; config = {}; inherit system; }
