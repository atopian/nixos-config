{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.libs.openssl;
in
{
   options.fruitcellar.libs.openssl = {
      enable = mkEnableOption "OpenSSL";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ openssl ];
   };
}