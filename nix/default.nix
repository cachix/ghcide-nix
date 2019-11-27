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

              # ghc -> terminfo dependency is broken; trying to add it manually...
              # This seems to be fixed in recent haskell.nix iirc
              # packages.hie-bios.components.library.depends = [config.hsPkgs.terminfo.components.library];
              # packages.hie-bios.components.exes.hie-bios.depends = [config.hsPkgs.terminfo.components.library];

              # This gives us a ghc lib without the ghci flag, which we need
              reinstallableLibGhc = true;
              # and adding this didn't compile
              packages.ghc.flags.ghci = pkgs.lib.mkForce true;
            })];
          };
      mkHieCore = args@{...}:
        let packages = mkPackages args;
        in packages.ghcide.components.exes.ghcide // { inherit packages; };
    in { export = {
          # ghcide-ghc881 = mkHieCore pkgs.haskell.compiler.ghc881;
          ghcide-ghc865 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; };
          ghcide-ghc864 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc864; stackYaml = "stack.yaml"; };
          ghcide-ghc844 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc844; stackYaml = "stack84.yaml"; };
          hie-bios = (mkPackages { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; }).hie-bios.components.exes.hie-bios;
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
