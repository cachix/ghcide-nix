{ sources ? import ./sources.nix
, system ? builtins.currentSystem
}:
let
  haskellnix = import sources."haskell.nix";
  overlay = _: pkgs:
    let
      mkPackages = { ghc, stackYaml }:
        pkgs.haskell-nix.stackProject {
            src = sources.ghcide;
            inherit stackYaml;
            modules = [({config, ...}: {
              ghc.package = ghc;
              compiler.version = pkgs.lib.mkForce ghc.version;
              reinstallableLibGhc = true;
              packages.ghc.flags.ghci = pkgs.lib.mkForce true;
              packages.ghci.flags.ghci = pkgs.lib.mkForce true;
              # This fixes a performance issue, probably https://gitlab.haskell.org/ghc/ghc/issues/15524
              packages.ghcide.configureFlags = [ "--enable-executable-dynamic" ];
              packages.ghcide.components.library.doHaddock = pkgs.lib.mkForce false;
              # Since GHC 8.8. Fix available but not released: https://github.com/blamario/monoid-subclasses/commit/2d3641af4b47fd448cc7c57940cb97c185cf0678
              packages.monoid-subclasses.components.library.doHaddock = pkgs.lib.mkForce false;
              nonReinstallablePkgs = [ "Cabal" "array" "binary" "base" "bytestring" "containers" "deepseq"
                                       "directory" "filepath" "ghc-boot" "ghc-boot-th" "ghc-compact"
                                       "ghc-heap" "ghc-prim" "ghci" "haskeline" "hpc" "integer-gmp"
                                       "libiserv" "mtl" "parsec" "pretty" "process" "rts" "stm"
                                       "template-haskell" "terminfo" "text" "time" "transformers" "unix"
                                       "xhtml"
                                     ];
            })];
          };
      mkGhcide = args@{...}:
        let packages = mkPackages ({ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; } // args);
        in packages.ghcide.components.exes.ghcide // { inherit packages; };
    in { export = {
          ghcide-ghc883 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc883; stackYaml = "stack88.yaml"; };
          ghcide-ghc865 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; };
          ghcide-ghc844 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc844; stackYaml = "stack84.yaml"; };
          hie-bios = (mkPackages { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; }).hie-bios.components.exes.hie-bios;
          inherit mkGhcide;
         };

         devTools = {
           inherit (import sources.niv {}) niv;
         };
      };
in
import sources.nixpkgs {
  overlays = haskellnix.overlays ++ [ overlay ];
  config = haskellnix.config // {};
  inherit system;
}
