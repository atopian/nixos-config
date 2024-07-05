{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.gcc;
in
{
   options.fruitcellar.apps.gcc = {
      enable = mkEnableOption "GCC";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ 
         gcc10
         cmake
         gnumake
         luajit
      ];
   };
}