{ pkgs ? import <nixpkgs> {} }:

{
  inherit (pkgs)

  # Base
  uutils-coreutils  #-noprefix ??

	# Essential
	bat
	bottom
	colordiff
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
