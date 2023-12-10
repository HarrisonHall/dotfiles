{ pkgs ? import <nixpkgs> {} }:

{
  inherit (pkgs)

	# Essential
	bat
	bottom
	colordiff
	fish  # NOTE: May need other installation to be usable with chsh
	gh
  git
	helix
	just
	tealdeer
	tmux
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
