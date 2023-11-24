{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.fruitcellar.services.avahi;
in
{
   options.fruitcellar.services.avahi = with types; {
      enable = mkBoolOpt false "Whether or not to enable avahi.";
      reflector = mkBoolOpt true "Enable reflector";
   };

   config = mkIf cfg.enable {
      services.avahi = {
         enable = true;
         reflector = cfg.reflector;
      };
   };
}