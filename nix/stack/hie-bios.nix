{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "hie-bios"; version = "0.0.0"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "Matthew Pickering <matthewtpickering@gmail.com>";
      author = "Kazu Yamamoto <kazu@iij.ad.jp> and Matthew Pickering <matthewtpickering@gmail.com>";
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
          (hsPkgs.containers)
          (hsPkgs.deepseq)
          (hsPkgs.directory)
          (hsPkgs.filepath)
          (hsPkgs.ghc)
          (hsPkgs.extra)
          (hsPkgs.process)
          (hsPkgs.transformers)
          (hsPkgs.file-embed)
          (hsPkgs.temporary)
          (hsPkgs.unix-compat)
          (hsPkgs.unordered-containers)
          (hsPkgs.yaml)
          (hsPkgs.vector)
          (hsPkgs.cryptohash-sha1)
          (hsPkgs.bytestring)
          (hsPkgs.base16-bytestring)
          (hsPkgs.time)
          (hsPkgs.text)
          ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.2") (hsPkgs.ghc-boot);
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
      rev = "7a75f520b2e7a482440edd023be8e267a0fa153f";
      sha256 = "1fb8hgzrgzk9g3rzzl6220z3d3mx26sm2kbwpydhk4c4bn22zv85";
      });
    }