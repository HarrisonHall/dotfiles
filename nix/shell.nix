{pkgs ? import <nixpkgs> {} }:

let

  term-core = import ./pkgs/term-core.nix {pkgs=pkgs;};

in
# {
  # inherit (environment.systemPackages)
  # environment.systemPackages;
  # with import ./pkgs/term-core.nix; environment.systemPackages
  term-core.environment.systemPackages
  # term-core.e
# }
