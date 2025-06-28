{
  description = "Collection of wallpapers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        folder = "wallpapers";
      in
      {
        packages = rec {
          wallpapers = pkgs.linkFarm "wallpapers" (
            pkgs.lib.mapAttrsToList (name: _: {
              inherit name;
              path = ./${folder}/${name};
            }) (builtins.readDir ./${folder})
          );

          default = wallpapers;
        };
      }
    );
}
