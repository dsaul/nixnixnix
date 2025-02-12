
{ config, lib, pkgs, modulesPath, ... }:

{
	services.nfs.server = {
		exports = ''
		/mnt				10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-01		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-02		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-03		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-04		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-05		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-06		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-07		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-08		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-09		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-10		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-11		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-12		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-13		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-14		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-15		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-16		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-17		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		/mnt/MEDIA-18		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		
		/mnt/DOCUMENTS-01	10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		
		/mnt/MISC-01		10.5.5.0/24(rw,nohide,sync,no_subtree_check)	172.16.0.0/24(rw,nohide,sync,no_subtree_check)	
		'';
	};
	
}
