{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.internal;
{
	imports = [ ./hardware.nix ];

	fruitcellar = {
		system = {
			boot = enabled;
			zfs = {
				enable = true;
				auto-snapshot = enabled;
			};
		};

		services = {
			ssh = enabled;
		};

		apps = {
			vim = enabled;
		};
	};

	system.stateVersion = "23.05";
}