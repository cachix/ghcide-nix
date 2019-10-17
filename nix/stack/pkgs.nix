{
  extras = hackage:
    {
      packages = {
        "prettyprinter" = (((hackage.prettyprinter)."1.3.0").revisions).default;
        "prettyprinter-ansi-terminal" = (((hackage.prettyprinter-ansi-terminal)."1.1.1.2").revisions).default;
        "hslogger" = (((hackage.hslogger)."1.3.0.0").revisions).default;
        "network-bsd" = (((hackage.network-bsd)."2.8.1.0").revisions).default;
        ghcide = ./ghcide.nix;
        haskell-lsp = ./haskell-lsp.nix;
        haskell-lsp-types = ./haskell-lsp-types.nix;
        lsp-test = ./lsp-test.nix;
        };
      };
  resolver = "nightly-2019-10-10";
  modules = [ ({ lib, ... }: { packages = {}; }) { packages = {}; } ];
  }