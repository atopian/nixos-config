{ 
   description = "Fruitcellar NixOS Config";
   # For new nodes, do a basic/generic nixos-install, then nixos-enter.
   #
   # nixos-generate-config --root /mnt
   # nixos-install --root /mnt
   # nixos-enter
   # mkdir -p ~/.config/nix
   # echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   # nix profile install github:snowfallorg/flake
   # rm -fr /root/.cache/nix && flake switch github:atopian/nixos-config#HOSTNAME

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
   };

   outputs = inputs:
      let
         lib = inputs.snowfall-lib.mkLib {
            inherit inputs;
            src = ./.;
         };
      in
      lib.mkFlake {
         package-namespace = "fruitcellar";

         overlays = with inputs; [ ];
      };
}