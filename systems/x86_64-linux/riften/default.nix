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
			enable = false;
			leader = true;
		};
	};

	system.stateVersion = "23.05";
}