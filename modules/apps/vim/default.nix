{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.vim;
in
{
   options.fruitcellar.apps.vim = {
      enable = mkEnableOption "Vim";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ vim ];
   };
}