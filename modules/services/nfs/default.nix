{ options, config, pkgs, lib, systems, name, format, inputs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.services.nfs;
in
{
   options.fruitcellar.services.ssh = with types; {
      enable = mkBoolOpt false "Enable NFS Server";
   };

   config = mkIf cfg.enable {
      services.nfs = {
         server.enable = true;
      };
   };
}