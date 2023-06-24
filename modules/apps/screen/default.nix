{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.screen;
in
{
   options.fruitcellar.apps.screen = {
      enable = mkEnableOption "Screen";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ screen ];
   };
}