
{ config, lib, pkgs, modulesPath, ... }:

{
	#showmount -e 10.5.5.5
	services.nfs.server = {
		enable = true;
		# fixed rpc.statd port; for firewall
		lockdPort = 4001;
		mountdPort = 4002;
		statdPort = 4000;
		extraNfsdConfig = '''';
	};
	
	networking.firewall.allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
	networking.firewall.allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
}
