{
  description = "skeen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      skeen = pkgs.stdenv.mkDerivation {
        name = "skeen";
        src = ./skeen;
        installPhase = ''
          mkdir -p $out
          ${pkgs.zip}/bin/zip -r $out/skeen.osk .
        '';
      };
    in
    {
      packages.default = skeen;
    }
  );
}
