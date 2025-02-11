{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		./system-docker.nix
	];

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
	];
}
