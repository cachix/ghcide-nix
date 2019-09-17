{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "hie-bios"; version = "0.1.1"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "Matthew Pickering <matthewtpickering@gmail.com>";
      author = "Matthew Pickering <matthewtpickering@gmail.com>";
      homepage = "https://github.com/mpickering/hie-bios";
      url = "";
      synopsis = "Set up a GHC API session";
      description = "Set up a GHC API session and obtain flags required to compile a source file";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs.base)
          (hsPkgs.base16-bytestring)
          (hsPkgs.bytestring)
          (hsPkgs.deepseq)
          (hsPkgs.containers)
          (hsPkgs.cryptohash-sha1)
          (hsPkgs.directory)
          (hsPkgs.filepath)
          (hsPkgs.time)
          (hsPkgs.extra)
          (hsPkgs.process)
          (hsPkgs.file-embed)
          (hsPkgs.ghc)
          (hsPkgs.transformers)
          (hsPkgs.temporary)
          (hsPkgs.text)
          (hsPkgs.unix-compat)
          (hsPkgs.unordered-containers)
          (hsPkgs.vector)
          (hsPkgs.yaml)
          ];
        };
      exes = {
        "hie-bios" = {
          depends = [
            (hsPkgs.base)
            (hsPkgs.directory)
            (hsPkgs.filepath)
            (hsPkgs.ghc)
            (hsPkgs.hie-bios)
            ];
          };
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/mpickering/hie-bios.git";
      rev = "68c662ea1d0e7095ccf2a4e3d393fc524e769bfe";
      sha256 = "09x47m8ljrrp9sm87s1xhzrxg7qh7dni5q28r90a4mrv4nk0zih3";
      });
    }