{ sources ? import ./sources.nix, system ? builtins.currentSystem }:

let
  overlay = _: pkgs:
    let
      mkPackages = { ghc, stackYaml }:
        let
          pkgSet = pkgs.haskell-nix.mkStackPkgSet {
            stack-pkgs = import ./stack/pkgs.nix;
            pkg-def-extras = [];
            modules = [{
                packages.ghcide.src = sources.ghcide;
                ghc.package = ghc; 
                compiler.version = pkgs.lib.mkForce ghc.version;
                reinstallableLibGhc = true;
                nonReinstallablePkgs =
                  ["ghc-boot" "binary" "process" "bytestring" "containers" "directory"
                   "filepath" "hpc" "ghci" "terminfo" "time" "transformers" "unix" "text" "base"
                  ] ++ pkgs.lib.optionals (ghc.version == "8.8.1") [ "contravariant" ];
            }];
          };
        in pkgSet.config.hsPkgs;
      mkHieCore = args:
        let packages = mkPackages args;
        in packages.ghcide.components.exes.ghcide;
    in { export = {
          #ghcide-ghc881 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc881; stackYaml = "stack881.yaml"; };
          ghcide-ghc865 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; };
          ghcide-ghc864 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc864; stackYaml = "stack.yaml"; };
          ghcide-ghc844 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc844; stackYaml = "stack84.yaml"; };
          hie-bios = (mkPackages { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; }).hie-bios.components.exes.hie-bios;
         };

         devTools = {
           inherit (import sources.niv {}) niv;
         };
      };
   haskellnix = import sources."haskell.nix";
in import sources.nixpkgs {
  overlays = haskellnix.overlays ++ [ overlay ];
  config = haskellnix.config // {};
  inherit system;
}
