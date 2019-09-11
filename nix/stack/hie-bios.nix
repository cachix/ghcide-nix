{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "hie-bios"; version = "0.1.0"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "Matthew Pickering <matthewtpickering@gmail.com>";
      author = "Matthew Pickering <matthewtpickering@gmail.com>";
      homepage = "https://github.com/mpickering/hie-bios";
      url = "";
      synopsis = "Set up a GHC API session";
      description = "";
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
      rev = "89e4ba24f87aac9909d9814b0e8c51b679a0ccd4";
      sha256 = "0pk13wf5h2ik2g1sdrhgfmq8078r61ynwpm0n6vxij7a30c0av39";
      });
    }