{ lib, config, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.fruitcellar.services.kube;
in
{
   options.fruitcellar.services.kube = with types; {
      enable = mkBoolOpt false "Whether or not to enable kube.";
      leader = mkBoolOpt false "Is the leader node";
      coredns = mkBoolOpt true "Enable CoreDNS";
      kubeLeaderIP = mkOpt str "10.200.50.20" "IP Address of the Leader Node";
      kubeLeaderHostname = mkOpt str "kube.fruitcellar.us" "Hostname of the Leader";
      kubeLeaderPort = mkOpt int 6443 "Port of the Leader";
      easyCerts = mkBoolOpt true "Use easy certs";
   };

   config = mkIf cfg.enable {
      # resolve master hostname
      networking.extraHosts = "${cfg.kubeLeaderIP} ${cfg.kubeLeaderHostname}";

      # packages for administration tasks
      environment.systemPackages = with pkgs; [
         kompose
         kubectl
         kubernetes
      ];

      services.kubernetes = let
         api = "https://${cfg.kubeLeaderHostname}:${toString cfg.kubeLeaderPort}";
      in
      {
         roles = ["node"] ++ (if cfg.leader then ["master"] else [ ]);
         masterAddress = cfg.kubeLeaderHostname;
         apiserverAddress = api;
         kubelet.kubeconfig.server = if !cfg.leader then api else "";
         easyCerts = cfg.easyCerts;
         apiserver = mkIf cfg.leader {
            securePort = cfg.kubeLeaderPort;
            advertiseAddress = cfg.kubeLeaderIP;
         };

         # use coredns
         addons.dns.enable = cfg.coredns;
      };
   };
}