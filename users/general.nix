
{ config, lib, pkgs, modulesPath, ... }:

{
	# Groups
	users.groups.media = {
		gid=990;
	};

	# Users

	users.mutableUsers = false;




}
