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
              packages.haskell-lsp.components.library.doHaddock = pkgs.lib.mkForce false;
              packages.ghcide.components.library.doHaddock = pkgs.lib.mkForce false;
            })];
          };
      mkGhcide = args@{...}:
        let packages = mkPackages ({ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; } // args);
        in packages.ghcide.components.exes.ghcide // { inherit packages; };
    in { export = {
          # ghcide-ghc881 = mkHieCore { ghc = pkgs.haskell-nix.compiler.ghc881; stackYaml = "stack88.yaml"; };
          ghcide-ghc865 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; };
          ghcide-ghc864 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc864; stackYaml = "stack.yaml"; };
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
