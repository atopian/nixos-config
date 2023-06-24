{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.fruitcellar.system.time;
in
{
   options.fruitcellar.system.time = with types; {
      enable = mkBoolOpt false "Whether or not to enable time mgt.";
      timeZone = mkOpt types.str "America/New_York";
   };

   config = mkIf cfg.enable {
      time.timeZone = cfg.timeZone;
   };
}