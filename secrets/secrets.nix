# Do not do this!
# config.password = builtins.readFile config.age.secrets.secret1.path;
let
	user-dan = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4DXCWnspO5WUrirR33EAGTIl692+COgeds0Tvtw6Yd"];
	user-lindsey = [];
	users = [ ] ++ user-dan ++ user-lindsey;
	users-admin = [ ] ++  user-dan ++ user-lindsey;

	system-cornwall-office-dan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTiiLVGhBMNj+VkMvCl3w1gQTT0Ah8Siw/cP6fZCdVn";
	system-cornwall-fileserver = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBIYQ275Dy/Kv3k2VjQuAk9SONeRilpky7zZ0CkcN+UZ";
	system-cornwall-tv = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfZeH0Gur/vvKTrzrK3QnWCrnCdUu+7EkWy8N+hvy8x";
	system-framework = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpLsawdwQzRrP6yyk3JsvPT+3+8wiMpNZb+w46/iI+6";
	systems = [ 
		system-cornwall-office-dan
		system-cornwall-fileserver
		system-cornwall-tv
		system-framework
	];
in
{
	"userHashedPasswordFile-dan.age".publicKeys = systems ++ users-admin ++ user-dan;
	"userHashedPasswordFile-lindsey.age".publicKeys = systems ++ users-admin ++ user-lindsey;
	"userHashedPasswordFile-root.age".publicKeys = systems ++ users-admin;
	"userHashedPasswordFile-tv.age".publicKeys = systems ++ users-admin;
	"fileserver-smb.age".publicKeys = systems ++ user-dan;
	"hetzner-dns.age".publicKeys = systems ++ user-dan;
	"davis-env.age".publicKeys = systems ++ user-dan;
	"navidrome-env.age".publicKeys = systems ++ user-dan;
	"gitea-env.age".publicKeys = systems ++ user-dan;
	"immich-env.age".publicKeys = systems ++ user-dan;
	"paperless-ngx-env.age".publicKeys = systems ++ user-dan;
	"foundryvtt-env.age".publicKeys = systems ++ user-dan;
	"pgadmin-env.age".publicKeys = systems ++ user-dan;
	"pgadmin-PGADMIN_DEFAULT_PASSWORD_FILE.age".publicKeys = systems ++ user-dan;
	"dbsysdb-env.age".publicKeys = systems ++ user-dan;
}