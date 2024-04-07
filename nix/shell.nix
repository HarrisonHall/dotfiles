{ pkgs ? import <nixpkgs> {} }:

{
  inherit (pkgs)

  # Base
  uutils-coreutils  #-noprefix ??

	# Essential
	bat
	bottom
	colordiff
  direnv
  eza
	fish  # NOTE: May need other installation to be usable with chsh
	gh
  git
	helix
	just
	tealdeer
	tmux
  tmuxp
	tree
  podman
  podman-compose
	ripgrep
	rustup
	
	# Bonus
	delta
	mdp
	tokei
	onefetch
	patchelf
	zig
	;
}
