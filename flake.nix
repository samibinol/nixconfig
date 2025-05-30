{ description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        # You could define packages, devShells, etc. here for each system.
        # For example:
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Example of a per-system output. Add your own here if needed.
        # devShells.default = pkgs.mkShell {
        #   buildInputs = [ pkgs.nixpkgs-fmt ];
        # };
      }
    ))
    //
    {
      nixosConfigurations =
        let
          mkNixosSystem = { system, hostname, extraModules ? [] }:
            nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs; };
              modules = [
                inputs.stylix.nixosModules.stylix
                inputs.home-manager.nixosModules.home-manager
                ./configuration.nix
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit inputs; };
                    # CHANGE THIS TO YOUR USERNAME
                    users.sam = {
                      imports = [ ./home.nix ];
                    };
                  };
                }
              ] ++ extraModules;
            };
        in
        {
          nixos-desktop = mkNixosSystem {
            system = "x86_64-linux";
            hostname = "nixos-desktop";
            extraModules = [
              ./desktop/configuration.nix
              { home-manager.users.sam.imports = [ ./desktop/home.nix ]; }
            ];
          };

	  nixos-laptop = mkNixosSystem {
            system = "x86_64-linux";
            hostname = "nixos-laptop";
            extraModules = [
              ./laptop/configuration.nix
              { home-manager.users.sam.imports = [ ./laptop/home.nix ]; }
            ];
          };
        };
    };
}
