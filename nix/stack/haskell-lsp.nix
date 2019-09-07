{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = { demo = false; };
    package = {
      specVersion = "1.22";
      identifier = { name = "haskell-lsp"; version = "0.15.0.0"; };
      license = "MIT";
      copyright = "Alan Zimmerman, 2016-2019";
      maintainer = "alan.zimm@gmail.com";
      author = "Alan Zimmerman";
      homepage = "https://github.com/alanz/haskell-lsp";
      url = "";
      synopsis = "Haskell library for the Microsoft Language Server Protocol";
      description = "An implementation of the types, and basic message server to\nallow language implementors to support the Language Server\nProtocol for their specific language.\n\nAn example of this is for Haskell via the Haskell IDE\nEngine, at https://github.com//haskell-ide-engine";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs.base)
          (hsPkgs.async)
          (hsPkgs.aeson)
          (hsPkgs.attoparsec)
          (hsPkgs.bytestring)
          (hsPkgs.containers)
          (hsPkgs.directory)
          (hsPkgs.data-default)
          (hsPkgs.filepath)
          (hsPkgs.hslogger)
          (hsPkgs.hashable)
          (hsPkgs.haskell-lsp-types)
          (hsPkgs.lens)
          (hsPkgs.mtl)
          (hsPkgs.network-uri)
          (hsPkgs.rope-utf16-splay)
          (hsPkgs.sorted-list)
          (hsPkgs.stm)
          (hsPkgs.temporary)
          (hsPkgs.text)
          (hsPkgs.time)
          (hsPkgs.unordered-containers)
          ];
        };
      exes = {
        "lsp-hello" = {
          depends = [
            (hsPkgs.base)
            (hsPkgs.aeson)
            (hsPkgs.bytestring)
            (hsPkgs.containers)
            (hsPkgs.directory)
            (hsPkgs.data-default)
            (hsPkgs.filepath)
            (hsPkgs.hslogger)
            (hsPkgs.lens)
            (hsPkgs.mtl)
            (hsPkgs.network-uri)
            (hsPkgs.rope-utf16-splay)
            (hsPkgs.stm)
            (hsPkgs.text)
            (hsPkgs.time)
            (hsPkgs.transformers)
            (hsPkgs.unordered-containers)
            (hsPkgs.vector)
            (hsPkgs.haskell-lsp)
            ];
          };
        };
      tests = {
        "haskell-lsp-test" = {
          depends = [
            (hsPkgs.base)
            (hsPkgs.QuickCheck)
            (hsPkgs.aeson)
            (hsPkgs.bytestring)
            (hsPkgs.containers)
            (hsPkgs.data-default)
            (hsPkgs.directory)
            (hsPkgs.filepath)
            (hsPkgs.hashable)
            (hsPkgs.haskell-lsp)
            (hsPkgs.hspec)
            (hsPkgs.lens)
            (hsPkgs.network-uri)
            (hsPkgs.quickcheck-instances)
            (hsPkgs.rope-utf16-splay)
            (hsPkgs.sorted-list)
            (hsPkgs.stm)
            (hsPkgs.text)
            ];
          build-tools = [
            (hsPkgs.buildPackages.hspec-discover or (pkgs.buildPackages.hspec-discover))
            ];
          };
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/alanz/haskell-lsp.git";
      rev = "bfbd8630504ebc57b70948689c37b85cfbe589da";
      sha256 = "1gsabw497qvj8fyk17awby0ny03dciahv0qh0is5w2wix2nwj5pa";
      });
    }