{ config, pkgs, ... }:
let cfg = config.fruitcellar.system.kube;
in
{
   options.fruitcellar.system.time = with types; {
      enable = mkBoolOpt false "Whether or not to enable kube.";
      leader = mkBoolOpt false "Is the leader node";
      coredns = mkBoolOpt true "Enable CoreDNS";
      kubeLeaderIP = mkOpt types.str "10.200.50.20";
      kubeLeaderHostname = mkOpt types.str "kube.fruitcellar.us";
      kubeLeaderPort = mkOpt types.int 6443;
   };

   config = mkIf cfg.enable {
      # resolve master hostname
      networking.extraHosts = "${kubeLeaderIP} ${kubeLeaderHostname}";

      # packages for administration tasks
      environment.systemPackages = with pkgs; [
         kompose
         kubectl
         kubernetes
      ];

      services.kubernetes = let
         api = "https://${kubeLeaderHostname}:${toString kubeLeaderPort}";
      in
      {
         roles = ["node"];
         
         if cfg.leader {
            roles = ["master"];
         };

         masterAddress = kubeLeaderHostname;
         apiserverAddress = api;
         kubelet.kubeconfig.server = if !cfg.leader api;
         easyCerts = true;
         apiserver = mkIf cfg.leader {
            securePort = kubeMasterAPIServerPort;
            advertiseAddress = kubeMasterIP;
         };

         # use coredns
         addons.dns.enable = cfg.coredns;
      };
   };
}