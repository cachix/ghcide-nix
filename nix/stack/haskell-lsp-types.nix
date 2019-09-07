{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "haskell-lsp-types"; version = "0.15.0.0"; };
      license = "MIT";
      copyright = "Alan Zimmerman, 2016-2018";
      maintainer = "alan.zimm@gmail.com";
      author = "Alan Zimmerman";
      homepage = "https://github.com/alanz/haskell-lsp";
      url = "";
      synopsis = "Haskell library for the Microsoft Language Server Protocol, data types";
      description = "An implementation of the types to allow language implementors to\nsupport the Language Server Protocol for their specific language.";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs.base)
          (hsPkgs.aeson)
          (hsPkgs.bytestring)
          (hsPkgs.data-default)
          (hsPkgs.deepseq)
          (hsPkgs.filepath)
          (hsPkgs.hashable)
          (hsPkgs.lens)
          (hsPkgs.network-uri)
          (hsPkgs.scientific)
          (hsPkgs.text)
          (hsPkgs.unordered-containers)
          ];
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/alanz/haskell-lsp.git";
      rev = "bfbd8630504ebc57b70948689c37b85cfbe589da";
      sha256 = "1gsabw497qvj8fyk17awby0ny03dciahv0qh0is5w2wix2nwj5pa";
      });
    postUnpack = "sourceRoot+=/haskell-lsp-types; echo source root reset to \$sourceRoot";
    }