let
  pkgs = import ./nix {};
  pkgSet = pkgs.haskellnix.mkStackPkgSet {
    stack-pkgs = import ./nix/stack/pkgs.nix;
    pkg-def-extras = [];
    modules = [
     { packages.Cabal.patches = [./nix/cabal.patch]; }
     { packages.happy.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
     { packages.pretty-show.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
     { packages.hie-core.src = pkgs.hie-core-src; }
     { nonReinstallablePkgs = ["ghc-boot"]; }
    ];
  };
  packages = pkgSet.config.hsPkgs;
in packages.hie-core.components.exes.hie-core
