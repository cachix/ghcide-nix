{
  extras = hackage:
    {
      packages = ({
        "haskell-lsp" = (((hackage.haskell-lsp)."0.16.0.0").revisions).default;
        "haskell-lsp-types" = (((hackage.haskell-lsp-types)."0.16.0.0").revisions).default;
        "lsp-test" = (((hackage.lsp-test)."0.7.0.0").revisions).default;
        "hie-bios" = (((hackage.hie-bios)."0.2.0").revisions).default;
        } // { ghcide = ./ghcide.nix; }) // {};
      };
  resolver = "nightly-2019-09-16";
  }