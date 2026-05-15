{
  description = "My flakes";

  nixConfig = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs?ref=nixos-unstable&shallow=1";
    flake-utils.url = "github:numtide/flake-utils";
    elephant.url = "github:abenz1267/elephant";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        doCheck = false;
      };
    };

    general = import ./modules/linux.nix { inherit pkgs; };

    all-pkgs = general;
  in {
    packages.all-pkgs = pkgs.symlinkJoin {
      name = "all-pkgs";
      paths = all-pkgs;
    };

  });
}
