{pkgs ? import <nixpkgs> {} }:

let

  term-core = import ./pkgs/term-core.nix {pkgs=pkgs;};

in

  term-core.environment.systemPackages
