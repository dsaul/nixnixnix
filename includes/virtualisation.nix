{ config, lib, pkgs, modulesPath, ... }:

{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];

	# Docker
	virtualisation.docker.enable = true;
	virtualisation.docker.package = pkgs.docker_25;
	virtualisation.docker.liveRestore = false;

	# Libvirt
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;
	virtualisation.libvirtd.qemu = {
		swtpm.enable = true;
		ovmf.packages = [ pkgs.OVMFFull.fd ];
	};

	#waydroid
	virtualisation.waydroid.enable = true;


	environment.systemPackages = with pkgs; [
		wl-clipboard

		qemu
		quickemu
		virt-manager
		libvirt
		basiliskii
	];
}
