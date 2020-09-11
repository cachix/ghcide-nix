{ sources ? import ./sources.nix
, haskellNix ? import sources."haskell.nix" {}
, nixpkgsSrc ? haskellNix.sources.nixpkgs-2003
, nixpkgsArgs ? haskellNix.nixpkgsArgs
, pkgs ? import nixpkgsSrc nixpkgsArgs
}: 

let
  mkPackages = { ghc, stackYaml }:
    pkgs.haskell-nix.stackProject {
        src = sources.ghcide;
        inherit stackYaml;
        modules = [({config, ...}: {
          ghc.package = ghc;
          compiler.version = pkgs.lib.mkForce ghc.version;
          packages.ghc.flags.ghci = pkgs.lib.mkForce true;
          packages.ghci.flags.ghci = pkgs.lib.mkForce true;
          # This fixes a performance issue, probably https://gitlab.haskell.org/ghc/ghc/issues/15524
          packages.ghcide.configureFlags = [ "--enable-executable-dynamic" ];
          packages.ghcide.components.library.doHaddock = pkgs.lib.mkForce false;
        })];
      };
  mkGhcide = args@{ ghc, stackYaml }:
    let 
      packages = mkPackages args;
    in packages.ghcide.components.exes.ghcide // { inherit packages; };
  
  devTools = {
    inherit (pkgs) niv;
  };
in { 
  export = {
    ghcide-ghc865 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; };
    ghcide-ghc884 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc884; stackYaml = "stack88.yaml"; };
    ghcide-ghc8102 = mkGhcide { ghc = pkgs.haskell-nix.compiler.ghc8102; stackYaml = "stack810.yaml"; };
    hie-bios = (mkPackages { ghc = pkgs.haskell-nix.compiler.ghc865; stackYaml = "stack.yaml"; }).hie-bios.components.exes.hie-bios;
    inherit mkGhcide;
  };

  inherit devTools;

  shell = pkgs.mkShell { 
    buildInputs = pkgs.lib.attrValues devTools;
  };
}
