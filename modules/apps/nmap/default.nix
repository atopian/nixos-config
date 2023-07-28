{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.nmap;
in
{
   options.fruitcellar.apps.nmap = {
      enable = mkEnableOption "Nmap";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ nmap ];
   };
}