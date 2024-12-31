
{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in
{
	services.pipewire.extraConfig.pipewire."91-null-sinks" = {

		"context.objects" = [
			{
				factory = "adapter";
				args = {
					"factory.name"     = "support.null-audio-sink";
					"node.name"        = "Virtual-Sink";
					"node.description" = "Virtual Sink";
					"media.class"      = "Audio/Sink";
					"audio.position"   = "FL FR FC LFE RL RR";
					"monitor.channel-volumes" = true;
				};
			}


			#{
			#	# A default dummy driver. This handles nodes marked with the "node.always-driver"
			#	# properyty when no other driver is currently active. JACK clients need this.
			#	factory = "spa-node-factory";
			#	args = {
			#	"factory.name"     = "support.node.driver";
			#	"node.name"        = "Dummy-Driver";
			#	"priority.driver"  = 8000;
			#	};
			#}
			#{
			#	factory = "adapter";
			#	args = {
			#	"factory.name"     = "support.null-audio-sink";
			#	"node.name"        = "Microphone-Proxy";
			#	"node.description" = "Microphone";
			#	"media.class"      = "Audio/Source/Virtual";
			#	"audio.position"   = "MONO";
			#	};
			#}
			#{
			#	factory = "adapter";
			#	args = {
			#	"factory.name"     = "support.null-audio-sink";
			#	"node.name"        = "Main-Output-Proxy";
			#	"node.description" = "Main Output";
			#	"media.class"      = "Audio/Sink";
			#	"audio.position"   = "FL,FR";
			#	};
			#}
		];
	};
}
