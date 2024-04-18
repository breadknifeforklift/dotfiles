{
  description = "NixOS configuration of breadknifeforklift";
  # what is consumed (previously provided by channels and fetchTarball)
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    impermanence.url = "github:Nix-community/impermanence";
    
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    nixos-wsl,
    home-manager,
    ...
  }@inputs: {
    nixosConfigurations = {
      kelsier = let device = "nvme0n1"; in nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs device; }; # forward inputs to modules
        modules = [
          inputs.disko.nixosModules.default
          (import ./disko.nix)
          ./hosts/kelsier
          inputs.impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sdober = import ./home;
          }
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # forward inputs to modules
        modules = [
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sdober = import ./home;
          }
        ];
      };
    };
  };
}
