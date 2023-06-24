{ options, config, pkgs, lib, systems, name, format, inputs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.services.ssh;
in
{
   options.fruitcellar.services.ssh = with types; {
      enable = mkBoolOpt false "Enable SSH Server";
   };

   config = mkIf cfg.enable {
      services.openssh = {
         enable = true;
         settings = {
            PermitRootLogin = "yes";
            PasswordAuthentication = true;
         };
      };
   };
}