{ config, lib, pkgs, modulesPath, ... }:
let
	packageName = "whishper";

	DB_USER = "whishper";
	DB_PASS = "whishper";

	## Check out https://github.com/LibreTranslate/LibreTranslate#configuration-parameters for more libretranslate configuration options
	LT_LOAD_ONLY = "en,fr";

	WHISPER_MODELS = "large-v3";

	WHISHPER_HOST = "https://whishper.dsaul.ca";

	WHISHPER_VERSION = "latest-gpu";
in
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	
	config.environment.etc."stacks/${packageName}/compose.yaml".text =
      /* yaml */
      ''
services:
  mongo:
    image: mongo
    restart: unless-stopped
    container_name: whishper-mongo
    user: root
    volumes:
      - /var/whishper/mongo/data:/data/db
      - /var/whishper/mongo/logs:/var/log/mongodb/
    environment:
      MONGO_INITDB_ROOT_USERNAME: ${DB_USER}
      MONGO_INITDB_ROOT_PASSWORD: ${DB_PASS}
    expose:
      - 27017
    command: ['--logpath', '/var/log/mongodb/mongod.log']

  translate:
    container_name: whisper-libretranslate
    image: libretranslate/libretranslate:latest-cuda
    restart: unless-stopped
    volumes:
      - /var/whishper/libretranslate/data:/home/libretranslate/.local/share
      - /var/whishper/libretranslate/cache:/home/libretranslate/.local/cache
    user: root
    tty: true
    environment:
      LT_DISABLE_WEB_UI: True
      LT_LOAD_ONLY: ${LT_LOAD_ONLY}
      LT_UPDATE_MODELS: True
      DB_USER: ${DB_USER}
      DB_USER: ${DB_PASS}
    expose:
      - 5000
    networks:
      default:
        aliases:
          - translate
    deploy:
      resources:
        reservations:
          devices:
          - driver: cdi
            device_ids:
              - nvidia.com/gpu=all
            capabilities: [gpu]

  whishper:
    pull_policy: always
    image: pluja/whishper:${WHISHPER_VERSION}
    volumes:
      - /var/whishper/uploads:/app/uploads
      - /var/whishper/logs:/var/log/whishper
    container_name: whishper
    user: root
    restart: unless-stopped
    networks:
      default:
        aliases:
          - whishper
    ports:
      - 8082:80
    depends_on:
      - mongo
      - translate
    environment:
      PUBLIC_INTERNAL_API_HOST: "http://127.0.0.1:80"
      PUBLIC_TRANSLATION_API_HOST: ""
      PUBLIC_API_HOST: ${WHISHPER_HOST}
      PUBLIC_WHISHPER_PROFILE: gpu
      WHISPER_MODELS_DIR: /app/models
      UPLOAD_DIR: /app/uploads
      DB_USER: ${DB_USER}
      DB_USER: ${DB_PASS}

    deploy:
      resources:
        reservations:
          devices:
          - driver: cdi
            device_ids:
              - nvidia.com/gpu=all
            capabilities: [gpu]

      '';

      config.systemd.services."${packageName}" = {
		wantedBy = ["multi-user.target"];
		after = ["docker.service" "docker.socket"];
		path = [pkgs.docker];
		script = ''
			docker compose -f /etc/stacks/${packageName}/compose.yaml up --remove-orphans
		'';
		restartTriggers = [
			config.environment.etc."stacks/${packageName}/compose.yaml".source
		];
	};

	config.system.activationScripts.makeWhishperDirs = lib.stringAfter [ "var" ] ''
		mkdir -p /var/whishper/mongo/data
		chown -R 999:999 /var/whishper/mongo/data
		mkdir -p /var/whishper/mongo/logs
		chown -R 999:999 /var/whishper/mongo/logs
		mkdir -p /var/whishper/libretranslate/data
		mkdir -p /var/whishper/libretranslate/cache
		mkdir -p /var/whishper/uploads
		mkdir -p /var/whishper/logs

		chmod a+w /var/whishper
	'';



}
	


