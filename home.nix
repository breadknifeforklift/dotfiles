{ pkgs, inputs, ... }:

{ 
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.persistence."/persist/home" = {
    directories = [
      ".gnupg"
      ".ssh"
      ".config"
    ];
    files = [
    ];
    allowOther = true;
  };
}