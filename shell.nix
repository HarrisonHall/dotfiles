{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # Tools for installing the environment:
    nativeBuildInputs = with pkgs.buildPackages; [
      fish
      just
      stow
      git
    ];
}
