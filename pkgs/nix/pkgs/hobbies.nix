# Hobbies configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # 日本語
    anki-bin

    # Games
    dolphin-emu  # GC/Wii emulation
    godot_4  # Godot engine
    sgt-puzzles  # Simon Tatham's puzzles

    # Music
    picard

    # Art
    aseprite 
    blender
    inkscape-with-extensions  # Inkscape
    krita
  ];
}
