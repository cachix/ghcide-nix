{ pkgs ? import <nixpkgs> {} }:
{
  /* buildExtension { src, overridePackage }

     src:     Source directory with package-lock.json, package.json etc

     overridePackage:
              Lets you override the build of the node package.
   */
  buildExtension = { src, overridePackage }:
    let
      inherit (pkgs) lib;
      inherit (pkgs.nodePackages) node2nix;
      inherit (import ./node2nix.nix { inherit pkgs; }) callNode2nix;

      nodePackages = callNode2nix { inherit src; inherit name; nodejs = pkgs.nodejs; };

      vsxbuild = overridePackage nodePackages.package;

      packageJSON = builtins.fromJSON (builtins.readFile "${src}/package.json");
      inherit (packageJSON) name publisher version;

      vsx = pkgs.runCommand "${name}-${version}.vsix" {} ''
        cp ${vsxbuild}/lib/node_modules/${name}/${name}-${version}.vsix $out
      '';

      # For pkgs.vscode-with-extensions
      installed = pkgs.vscode-utils.buildVscodeExtension {
        inherit name;
        # .zip for easy auto unpack
        src = vsx.overrideAttrs (a: { name = "vsx.zip"; });
        # Same as "Unique Identifier" on the extension's web page.
        # For the moment, only serve as unique extension dir.
        vscodeExtUniqueId = "${publisher}.${name}";
      };

    in pkgs.recurseIntoAttrs {
      inherit
        vsx
        installed;
    };
}