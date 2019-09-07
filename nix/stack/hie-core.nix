{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "1.18";
      identifier = { name = "hie-core"; version = "0"; };
      license = "BSD-3-Clause";
      copyright = "Digital Asset 2018-2019";
      maintainer = "Digital Asset";
      author = "Digital Asset";
      homepage = "https://github.com/digital-asset/daml#readme";
      url = "";
      synopsis = "The core of an IDE";
      description = "A library for building Haskell IDE's on top of the GHC API.";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs.aeson)
          (hsPkgs.async)
          (hsPkgs.base)
          (hsPkgs.binary)
          (hsPkgs.bytestring)
          (hsPkgs.containers)
          (hsPkgs.data-default)
          (hsPkgs.deepseq)
          (hsPkgs.directory)
          (hsPkgs.extra)
          (hsPkgs.filepath)
          (hsPkgs.ghc-boot-th)
          (hsPkgs.ghc-boot)
          (hsPkgs.ghc)
          (hsPkgs.hashable)
          (hsPkgs.haskell-lsp-types)
          (hsPkgs.haskell-lsp)
          (hsPkgs.mtl)
          (hsPkgs.network-uri)
          (hsPkgs.prettyprinter-ansi-terminal)
          (hsPkgs.prettyprinter-ansi-terminal)
          (hsPkgs.prettyprinter)
          (hsPkgs.rope-utf16-splay)
          (hsPkgs.safe-exceptions)
          (hsPkgs.shake)
          (hsPkgs.sorted-list)
          (hsPkgs.stm)
          (hsPkgs.syb)
          (hsPkgs.text)
          (hsPkgs.time)
          (hsPkgs.transformers)
          (hsPkgs.unordered-containers)
          (hsPkgs.utf8-string)
          ] ++ (pkgs.lib).optional (!system.isWindows) (hsPkgs.unix);
        };
      exes = {
        "hie-core" = {
          depends = [
            (hsPkgs.base)
            (hsPkgs.containers)
            (hsPkgs.data-default)
            (hsPkgs.directory)
            (hsPkgs.extra)
            (hsPkgs.filepath)
            (hsPkgs.ghc-paths)
            (hsPkgs.ghc)
            (hsPkgs.haskell-lsp)
            (hsPkgs.hie-bios)
            (hsPkgs.hie-core)
            (hsPkgs.optparse-applicative)
            (hsPkgs.shake)
            (hsPkgs.text)
            ];
          };
        };
      tests = {
        "hie-core-tests" = {
          depends = [
            (hsPkgs.base)
            (hsPkgs.containers)
            (hsPkgs.extra)
            (hsPkgs.filepath)
            (hsPkgs.haskell-lsp-types)
            (hsPkgs.lens)
            (hsPkgs.lsp-test)
            (hsPkgs.parser-combinators)
            (hsPkgs.tasty)
            (hsPkgs.tasty-hunit)
            (hsPkgs.text)
            ];
          build-tools = [
            (hsPkgs.buildPackages.hie-core or (pkgs.buildPackages.hie-core))
            ];
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ../../../../../../.././.; }