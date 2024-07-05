{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.internal;
{
	imports = [ ./hardware.nix ];

	fruitcellar = {
		role.k8s = enabled;

		system.zfs = {
			enable = true;
			auto-snapshot = enabled;
		};

		services.kube.leader = true;
		services.nfs.enable  = true;
		services.samba.enable = true;

		apps = {
			nmap.enable = true;
			tcpdump.enable = true;
			python.enable = true;
			gcc.enable = true;
			mariadb.enable = true;
			zeromq.enable = true;
		};
	};

	system.stateVersion = "23.05";
}