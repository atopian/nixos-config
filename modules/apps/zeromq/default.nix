{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.zeromq;
in
{
   options.fruitcellar.apps.zeromq = {
      enable = mkEnableOption "ZeroMQ";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ 
         zeromq
      ];
   };
}