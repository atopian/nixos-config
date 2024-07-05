{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let
   cfg = config.fruitcellar.apps.python;
in
{
   options.fruitcellar.apps.python = {
      enable = mkEnableOption "Python";
   };
   
   config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ 
         python3
         python310Packages.pip
         python310Packages.mariadb
         python310Packages.gitpython
         python310Packages.pylint
         python310Packages.pyyaml
         python310Packages.colorama
         python310Packages.pyzmq
         python310Packages.black
         python310Packages.regex
      ];
   };
}