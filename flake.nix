{
  description = "NixOS config for Raspberry Pi 4";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, flake-utils, nixos-hardware, ... }:
		{
      nixosConfigurations.rpi4 = nixpkgs.lib.nixosSystem {
					
        system = "aarch64-linux";

        modules = [
          "${nixos-hardware}/raspberry-pi/4" # RPi-specific config
"${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          ./configuration.nix  
					{
						nixpkgs.buildPlatform = builtins.currentSystem;
						nixpkgs.hostPlatform = "aarch64-linux";
					}            
        ];
      };
    };
}
