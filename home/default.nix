{ config, pkgs, inputs, lib, ... }:

{ 
  imports = [
    ./fish.nix
    ./helix.nix
    ./firefox.nix
    ./wezterm.nix
    # inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # home.persistence."/persist/home" = {
  #   directories = [
  #   ];
  #   files = [
  #   ];
  #   allowOther = true;
  # };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    dconf # used for backend to GNOME settings when no desktop env
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme = true
  '';

  programs = {
    git = {
      enable = true;
      userName = "breadknifeforklift";
      userEmail = "breadknifeforklift@proton.me";
      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "hx";
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingKey = "/home/sdober/.ssh/id_ed25519_sk_rk_git_breadknifeforklift.pub";
      };
    };
    lazygit.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
