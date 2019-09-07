let
  pkgs = import ./nix {};
  pkgSet = pkgs.haskellnix.mkStackPkgSet {
    stack-pkgs = import (pkgs.haskellnix.callStackToNix {
      src = pkgs.hie-core-src;
    });
    pkg-def-extras = [];
    modules = [
     { packages.Cabal.patches = [./nix/cabal.patch]; }
     { packages.happy.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
     { packages.pretty-show.package.setup-depends = [pkgSet.config.hsPkgs.Cabal]; }
     { packages.cachix.components.library.build-tools = [ pkgs.boost ]; }
    ];
  };
  packages = pkgSet.config.hsPkgs;
in packages.hie-core.components.exes.hie-core
