{ config, pkgs, inputs, lib, ... }:

{ 
  imports = [
    ../../home
    ../../home/sway.nix
  ];

  mod = "Mod1";
  home.sessionVariables = {
    XDG_RUNTIME_DIR = "/mnt/wslg/runtime-dir";
    DISPLAY = ":0";
  };
}
