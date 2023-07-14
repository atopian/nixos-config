{ options, config, pkgs, lib, systems, name, format, inputs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.services.samba;
in
{
   options.fruitcellar.services.samba = with types; {
      enable = mkBoolOpt false "Enable Samba Server";
      securityType = mkOpt str "user" "Security Type";
   };

   config = mkIf cfg.enable {
      services.samba = {
         enable = true;
         securityType = cfg.securityType;
         extraConfig = ''
            workgroup = RANGERNET
            server string = riften
            netbios name = riften
            security = user 
            #use sendfile = yes
            #max protocol = smb2
            # note: localhost is the ipv6 localhost ::1
            hosts allow = 10.200. 127.0.0.1 localhost
            hosts deny = 0.0.0.0/0
            guest account = nobody
            map to guest = bad user
         '';
         shares = {
            Movies = {
               path = "/shared/Movies";
               browseable = "yes";
               "read only" = "yes";
               "guest ok" = "yes";
            };
            TV = {
               path = "/shared/TV";
               browseable = "yes";
               "read only" = "yes";
               "guest ok" = "yes";
            };
            shared = {
               path = "/shared";
               browseable = "yes";
               "read only" = "yes";
               "guest ok" = "yes";
            };
         };
      };
   };
}
