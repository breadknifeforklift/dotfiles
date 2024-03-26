{
  description = "Nixos config flake";
  # what is consumed (previously provided by channels and fetchTarball)
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    nixosConfigurations = let device = "sda"; in {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs device; }; # forward inputs to modules
        modules = [
          inputs.disko.nixosModules.default
          (import ./disko.nix)

          ./configuration.nix
          inputs.impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.stephan = import ./home.nix;
          }
        ];
      };
    };
  };
}
