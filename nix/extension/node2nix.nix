{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib;
  inherit (pkgs.nodePackages) node2nix;

  runNode2nix = { src, name }:
    let
      packageJSON = builtins.fromJSON (builtins.readFile "${src}/package.json");
      version = packageJSON.version;
      sourceUnpack =
        if lib.canCleanSource src
        then {
          src = lib.cleanSourceWith {
            inherit src;
            name = "node2nix-${name}-source";
            filter = path: type:
              let b = baseNameOf path;
              in b == "package.json"
                  ||
                b == "package-lock.json";
          };
        }
        else {
          unpackPhase = ''
            cp ${src}/package.json package.json
            cp ${src}/package-lock.json package-lock.json
          '';
        };
    in
    pkgs.stdenv.mkDerivation ({
      name = "node2nix-${name}-${version}.nix";
      inherit version;
      buildInputs = [ node2nix ];

      # TODO: make the flags configurable and select appropriate nodejs version
      #       automatically
      buildPhase = ''
        node2nix \
          --nodejs-10 \
          --development \
          -l \
          package-lock.json \
          ;
        sed -i \
          -e 's%src = ./.%inherit src%' \
          -e 's%{nodeEnv%{src ? ./., nodeEnv%' \
          node-packages.nix \
          ;
        sed -i \
          -e 's%{pkgs ?%{src ? ./., pkgs ?%' \
          -e 's%inherit nodeEnv%inherit nodeEnv src%' \
          default.nix \
          ;
      '';
      installPhase = ''
        mkdir $out
        cp -a * $out
      '';
    }
    // sourceUnpack);

  callNode2nix = { src, name, nodejs }:
    import (runNode2nix { inherit src name; })
      {
        inherit pkgs src nodejs;
        inherit (pkgs) system;
      };

in {
  inherit
    callNode2nix
    runNode2nix;
}