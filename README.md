# Getting started

## 1. Use Cachix to avoid compilation (optional if you like compiling for 2h)

    $ nix-env -iA cachix -f https://cachix.org/api/v1/install
    $ cachix use hercules-ci

## 2. Install hie-core

1. $ nix-env -iA hie-core -f https://github.com/hercules-ci/hie-core-nix/tarball/master
2. [Continue with upstream steps](https://github.com/digital-asset/daml/tree/master/compiler/hie-core#test-hie-core)

# FAQ

## Why does this repo sit in hercules-ci organization?

It was the easiest to setup, it will hopefully merge with hie-core.

## Why is only GHC 8.6.5 supported?

This is a proof of concept, all other GHC versions are yet to be supported.