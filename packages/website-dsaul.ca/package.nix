{ buildNpmPackage
, lib, ... }:
let
#	age.secrets."id_ed25519-www.dsaul.ca-nixos_package".file = ../../secrets/id_ed25519-www.dsaul.ca-nixos_package.age;
#https://joshkingsley.me/blog/publishing-static-site-nix.html
in
buildNpmPackage {
	name = "website-dsaul.ca";
	src = builtins.fetchgit {
		url = "git@github.com:dsaul/www.dsaul.ca.git";
		rev = "a3d7a33b4eb547a5b9c1f32159bf5f656e960481";
		hash = "";
		#fetchSubmodules = true;
		#extraConfig = {
		#	core = {
		#		sshCommand = "ssh -i /path/to/your/private_key -F /dev/null";
		#	};
		#};
	};
	npmDepsHash = lib.fakeHash;
}