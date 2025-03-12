{ buildNpmPackage, lib, ... }:


#https://joshkingsley.me/blog/publishing-static-site-nix.html

buildNpmPackage {
	name = "website-dsaul.ca";
	src = fetchgit {
		url = "git@github.com:dsaul/www.dsaul.ca.git";
		rev = "a3d7a33b4eb547a5b9c1f32159bf5f656e960481";
		hash = "";
		#fetchSubmodules = true;
		extraConfig = {
			core = {
				sshCommand = "ssh -i /path/to/your/private_key -F /dev/null";
			};
		};
	};
	npmDepsHash = lib.fakeHash;
}