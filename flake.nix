{
  description = "Nixos config flake";
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
      inputs.nixpkgs.follow = "nixpkgs";
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
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs }; # forward inputs to modules
        modules = [
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/nvme0n1"; })

          ./configuration.Nix
          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
        ];
      };
    };
  };
}
