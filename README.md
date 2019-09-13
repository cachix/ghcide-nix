# Getting started

## 1. Use Cachix to avoid compilation (optional if you like compiling for 2h)

    $ nix-env -iA cachix -f https://cachix.org/api/v1/install
    $ cachix use hercules-ci

## 2. Install ghcide

Currently available for `ghc865`, `ghc864` and `ghc844`:

### On NixOS

```nix
environment.systemPackages = [
  (import (builtins.fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/master") {}).ghcide-ghc865
];
```

### With Nix

    $ nix-env -iA ghcide-ghc865 -f https://github.com/hercules-ci/ghcide-nix/tarball/master

## 3. Install integration

### VSCode mutable

    code --install-extension $(nix-build -A vscode-extension.vsx)

### VSCode immutable

For the purists (or people who have a broken mutable setup)

Home manager:

    programs.vscode.extensions = [
      (import ghcide-nix-src {}).vscode-extension.installed
    ];

Nixpkgs:

    vscode-with-extensions.override {
      vscodeExtensions = [
        (import ~/h/ghcide-nix {}).vscode-extension.installed
      ];
    }

## 4. [Following upstream project setup instructions](https://github.com/digital-asset/ghcide#test-ghcide)

# FAQ

## Why does this repo sit in hercules-ci organization?

It was the easiest to setup, it will [hopefully merge with ghcide](https://github.com/digital-asset/ghcide/issues/56)
