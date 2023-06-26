{ options, config, pkgs, lib, systems, name, format, inputs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.role.server;
in
{
   options.fruitcellar.role.server = with types; {
      enable = mkBoolOpt false "Enable Common Server Config";
   };

   config = mkIf cfg.enable {
      fruitcellar = {
         system.boot = enabled;
			system.time = enabled;
         services.ssh = enabled;
         apps.lsof = enabled;
         apps.screen = enabled;
         apps.vim = enabled;
         libs.openssl = enabled;
      };
   };
}