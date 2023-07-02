{
  description = "skeen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      skeen = pkgs.stdenv.mkDerivation {
        name = "skeen";
        # version = "0.1.0";
        src = ./.;

        buildPhase = ''
          ${pkgs.zip}/bin/zip -r build/skeen.osk . -x "build/*" ".git/*"
        '';
        installPhase = ''
          mkdir -p $out
          cp build/skeen.osk $out/skeen.osk
        '';
      };
    in
    {
      packages.default = skeen;
    }
  );
}
