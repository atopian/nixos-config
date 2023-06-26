{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.internal;
{
	imports = [ ./hardware.nix ];

	fruitcellar = {
		system = {
			boot = enabled;
			time = enabled;
			zfs = {
				enable = true;
				auto-snapshot = enabled;
			};
		};

		services.ssh = enabled;
		apps.lsof = enabled;
		apps.screen = enabled;
		apps.vim = enabled;
		libs.openssl = enabled;
		services.kube = {
			enable = true;
			leader = true;
			flannelIface = "vlan50";
		};
	};

	system.stateVersion = "23.05";
}