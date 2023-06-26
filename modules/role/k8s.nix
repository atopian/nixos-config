{ options, config, pkgs, lib, systems, name, format, inputs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.role.k8s;
in
{
   options.fruitcellar.role.k8s = with types; {
      enable = mkBoolOpt false "Enable Kube Server Role";
   };

   config = mkIf cfg.enable {
      fruitcellar = {
         role.server = enabled;
         services.kube = enabled;
      };
   };
}