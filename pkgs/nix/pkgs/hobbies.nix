# Hobbies configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # 日本語
    # anki-bin  # TODO: Anki is bloated.

    # Games
    # dolphin-emu  # GC/Wii emulation
    # unstable.godot  # Godot engine
    sgt-puzzles  # Simon Tatham's puzzles

    # Music
    picard

    # Art
    # aseprite 
    # libresprite
    blender
    inkscape-with-extensions  # Inkscape
    # krita
  ];
}
