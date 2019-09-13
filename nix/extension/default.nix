{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs.callPackage ./vscode-extension.nix {}) buildExtension;
  src = (import ../sources.nix).ghcide + "/extension";
in
buildExtension {
  inherit src;
  overridePackage = pkg: pkg.overrideAttrs (a: {
    postInstall = ''
      npm run vscepackage
    ''; 
  });
}
