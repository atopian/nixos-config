{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.python;
in
{
   options.fruitcellar.apps.python = {
      enable = mkEnableOption "Python";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ python3 ];
   };
}