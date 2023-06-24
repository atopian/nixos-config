{ 
   description = "Fruitcellar NixOS Config"

   inputs = {
      # NixOS Packages (Stable - 23.05)
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

      # NixOS Packages (Unstable)
      unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      # Hardware Configuration
      nixos-hardware.url = "github:nixos/nixos-hardware";

      # macOS Support (master)
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs";

      # Snowfall Lib
      snowfall-lib.url = "github:snowfallorg/lib/dev";
      snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

      # Snowfall Flake
      flake.url = "github:snowfallorg/flake";
      flake.inputs.nixpkgs.follows = "nixpkgs";
   }

   outputs = inputs:
      let
         lib = inputs.snowfall-lib.mkLib {
            inherit inputs;
            src ./.;
         };
      in
      lib.mkFlake {
         package-namespace = "fruitcellar";
      }

      overlays = with inputs; [ ];


}