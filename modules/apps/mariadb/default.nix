{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.mariadb;
in
{
   options.fruitcellar.apps.mariadb = {
      enable = mkEnableOption "MariaDB";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ 
         mariadb
      ];
   };
}