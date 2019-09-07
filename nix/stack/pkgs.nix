{
  extras = hackage:
    {
      packages = {} // {
        hie-core = ./hie-core.nix;
        haskell-lsp = ./haskell-lsp.nix;
        haskell-lsp-types = ./haskell-lsp-types.nix;
        lsp-test = ./lsp-test.nix;
        hie-bios = ./hie-bios.nix;
        };
      };
  resolver = "nightly-2019-05-20";
  }