{
    description = "Dan's";

    inputs = {
        nixpkgs.url        = "github:NixOS/nixpkgs/nixos-24.11";
        nixos-hardware.url = "github:NixOS/nixos-hardware";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
    };

    outputs = { self, nixpkgs, nix, nixos-hardware, home-manager}: {
        nixosConfigurations = {
            framework = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    nixos-hardware.nixosModules.framework-11th-gen-intel
                    ./hosts/framework-hardware-configuration.nix
                    ./hosts/framework.nix
                    #./hosts/thinknix52.nix
                    #./users/chrism/user.nix
                    #home-manager.nixosModules.home-manager {
                    #  home-manager.useUserPackages = true;
                    #  home-manager.users.chrism = import ./users/chrism/hm.nix;
                    #}
                ];
            };
        };
    };
}
