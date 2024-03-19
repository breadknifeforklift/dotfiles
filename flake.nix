{
  description = "Nixos config flake";
  device = "sda";
  # what is consumed (previously provided by channels and fetchTarball)
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    impermanence.url = "github:Nix-community/impermanence";
    
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # what will be produced (i.e. the build)
  outputs = {
    self,
    nixpkgs,
    impermanence,
    home-manager,
    ...
  }@inputs: {
    templates.default = {
      description = "My default template";
      path = ".";
    };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs device; }; # forward inputs to modules
        modules = [
          inputs.disko.nixosModules.default
          (import ./disko.nix)

          ./configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
        ];
      };
    };
  };
}
