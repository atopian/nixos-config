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
		apps.vim = enabled;
		apps.screen = enabled;
		libs.openssl = enabled;
		services.kube = {
			enable = true;
			leader = true;
		};
	};

	system.stateVersion = "23.05";
}