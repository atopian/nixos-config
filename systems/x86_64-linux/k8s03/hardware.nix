{ config, lib, pkgs, modulesPath, nixos-hardware, ... }:

{
   imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot = {
		initrd = {
			availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "megaraid_sas" "nvme" "usbhid" "usb_storage" "sd_mod" ];
			kernelModules = [ "kvm-intel" ];
		};

		extraModulePackages = [ ];
	};

	# Core filesystems needed for boot, we'll use ZFS native for the rest
	fileSystems = {
		"/" = {
			device = "rpool/nixos/root";
			fsType = "zfs";
		};

		"/boot" = {
			device = "/dev/disk/by-uuid/43AC-C129";
			fsType = "vfat";
		};

		"/nix" = {
			device = "rpool/nixos/nix";
			fsType = "zfs";
		};
		
		"/var" = {
			device = "rpool/nixos/var";
			fsType = "zfs";
		};

		"/var/lib" = {
			device = "rpool/nixos/var/lib";
			fsType = "zfs";
		};

		"/var/log" = {
			device = "rpool/nixos/var/log";
			fsType = "zfs";
		};
	};
	
	networking = {
		hostId = "c45d93ab";
		hostName = "k8s03";
		domain = "fruitcellar.us";
		dhcpcd.enable = false;
		firewall.enable = false;
		usePredictableInterfaceNames = true;
		interfaces.eno1.ipv4.addresses = [{
			address = "10.200.69.69";
			prefixLength = 24;
		}];
		vlans = {
			vlan50 = { id=50; interface="eno1"; };
      };
		interfaces.vlan50.ipv4.addresses = [{
			address = "10.200.50.23";
			prefixLength = 20;
      }];

		defaultGateway = "10.200.69.1";
		nameservers = [ "10.200.69.1" ];
	};
}
