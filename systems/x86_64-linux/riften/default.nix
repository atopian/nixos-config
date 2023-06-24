{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.internal;
{
	imports = [ ./hardware.nix ];

	config = {
		networking = {
			hostId = "d30a091e";
			hostName = "riften";
			domain = "fruitcellar.us";
			dhcpcd.enable = false;
			usePredictableInterfaceNames = true;
			interfaces.eth1.ipv4.addresses = [{
				address = "10.200.69.66";
				prefixLength = 24;
			}];


			defaultGateway = "10.200.69.1";
			nameservers = [ "10.200.69.1" ];
		};
	};
	
	system.stateVersion = "23.05";
}