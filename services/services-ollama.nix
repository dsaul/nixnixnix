
	
	

{ config, lib, pkgs, modulesPath, ... }:

{
	services.ollama = {
		enable = true;
		loadModels = [
			"codellama:13b"
			"deepseek-r1:14b"
			"deepseek-coder-v2:latest"
			"mistral"
		];
	};
	services.open-webui = {
		enable = true;
		port = 25365;
		openFirewall = true;
		host = "0.0.0.0";
	};
}
