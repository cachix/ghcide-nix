# Getting started

## 1. Use Cachix binary cache(optional if you like compiling for 2h)

    $ nix-env -iA cachix -f https://cachix.org/api/v1/install
    $ cachix use ghcide-nix

## 2. Install ghcide

Currently available for `ghc8102`, `ghc884` and `ghc865`:

### On NixOS

```nix
environment.systemPackages = [
  (import (builtins.fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master") {}).ghcide-ghc884
];
```

### With Nix

    $ nix-env -iA ghcide-ghc884 -f https://github.com/cachix/ghcide-nix/tarball/master

## 3. [Continue by following upstream instructions](https://github.com/digital-asset/ghcide#test-ghcide)

# Updating

    ./update
