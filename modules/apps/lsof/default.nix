{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.lsof;
in
{
   options.fruitcellar.apps.lsof = {
      enable = mkEnableOption "lsof";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ lsof ];
   };
}