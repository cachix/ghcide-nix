{ pkgs ? import ./nix {} }:
pkgs.mkShell
  { buildInputs = pkgs.lib.attrValues pkgs.devTools;
  }
