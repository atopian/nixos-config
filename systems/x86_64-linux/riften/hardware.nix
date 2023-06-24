{ config, lib, pkgs, modulesPath, nixos-hardware, ... }:

{
   imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot = {
		initrd = {
			availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "megaraid_sas" "nvme" "usbhid" "usb_storage" "sd_mod" ];
			kernelModules = [ ];
		};

		extraModulePackages = [ ];
	};

	fileSystems = {
		"/" = {
			device = "rpool/riften/root";
			fsType = "zfs";
		};

		"/boot" = {
			device = "/dev/disk/by-label/boot";
			fsType = "vfat";
		};

		"/nix" = {
			device = "rpool/riften/nix";
			fsType = "zfs";
		};
		
		"/var" = {
			device = "rpool/riften/var";
			fsType = "zfs";
		};
	};
	
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
}
