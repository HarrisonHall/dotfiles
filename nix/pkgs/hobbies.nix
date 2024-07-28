# Hobbies configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # 日本語
    anki-bin

    # Games
    godot_4  # Godot engine
    sgt-puzzles  # Simon Tatham's puzzles
  ];
}
