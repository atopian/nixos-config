{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.lsof;
in
{
   options.fruitcellar.apps.tcpdump = {
      enable = mkEnableOption "tcpdump";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ tcpdump ];
   };
}