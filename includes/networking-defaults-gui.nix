{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <nixos-unstable> { system = "x86_64-linux"; config.allowUnfree = true; config.allowBroken = true; };
in 
{
	#imports =
	#  [ (modulesPath + "/installer/scan/not-detected.nix")
	#  ];
	
	programs.mtr.enable = true;	

	environment.systemPackages = with pkgs; [
		mtr-gui
		transmission_4-qt
		unstable.winbox4
		remmina
		wireshark
		seafile-client
		freerdp
		freerdp3
		ungoogled-chromium
	];

	programs.firefox = {
		enable = true;
		preferences = {
			"widget.use-xdg-desktop-portal.file-picker" = 1;
			
			# Disable mozilla injecting preferences.
			"app.normandy.api_url" = ""; 
			"app.normandy.enabled" = false;
			
			# No we don't want to be your guinea pigs.
			"app.shield.optoutstudies.enabled" = false;
			"experiments.activeExperiment" = false;
			"experiments.enabled" = false;
			"experiments.manifest.uri" = "";
			"experiments.supported" = false;
			"network.allow-experiments" = false;
			"network.cookie.cookieBehavior" = 1;
			
			"app.update.auto" = false; # No auto updates.
			"beacon.enabled" = false; # Don't tell websites what you click on.
			"browser.send_pings" = false; # Don't tell websites what you click on.
			"breakpad.reportURL" = ""; # Don't send crash reports.
			"browser.crashReports.unsubmittedCheck.autoSubmit" = false; # Don't send crash reports.
			"browser.crashReports.unsubmittedCheck.autoSubmit2" = false; # Don't send crash reports.
			"browser.crashReports.unsubmittedCheck.enabled" = false; # Don't send crash reports.
			
			"browser.disableResetPrompt" = true; # don't prompt to reset after period of inactivity
			
			"browser.aboutConfig.showWarning" = false; # don't show danger warning on about:config
			"browser.fixup.alternate.enabled" = false; # don't have firefox attempt to change uris
			
			"browser.newtab.preload" = false; # disable preloading of pages on new tab
			"browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # fuck pocket
			"browser.newtabpage.enhanced" = false; # disable new tab ads
			"browser.newtabpage.introShown" = true;  # disable new tab ads
			"services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
			"browser.newtabpage.introShown" = true;
			"pdfjs.enableScripting" = false;





			# disable safebrowsing (send everything to google)
			"browser.safebrowsing.appRepURL" = "";
			"browser.safebrowsing.blockedURIs.enabled" = false;
			"browser.safebrowsing.downloads.enabled" = false;
			"browser.safebrowsing.downloads.remote.enabled" = false;
			"browser.safebrowsing.downloads.remote.url" = "";
			"browser.safebrowsing.enabled" = false;
			"browser.safebrowsing.malware.enabled" = false;
			"browser.safebrowsing.phishing.enabled" = false;

			
			"browser.search.suggest.enabled" = false; # disable sending typed form data to search provider
			"browser.selfsupport.url" = ""; # Disable metrics to mozilla.

			"browser.sessionstore.privacy_level" = 0; # Allow session restore to contain form fields.
			"browser.shell.checkDefaultBrowser" = true; # prompt if not default browser
			"browser.startup.homepage_override.mstone" = "ignore"; # no you don't change my homepage automatically, wtf
			"browser.tabs.crashReporting.sendReport" = false; # disable sending of crash reports
			"browser.urlbar.groupLabels.enabled" = false; # disable firefox suggest
			"browser.urlbar.quicksuggest.enabled" = false; # disable firefox suggest
			"browser.urlbar.speculativeConnect.enabled" = false; # don't connect unless we actually try to connect
			"browser.urlbar.trimURLs" = false; # don't hide part of the url bar, wtf
			#"keyword.enabled" = false;
			"network.IDN_show_punycode" = false;
			
			# disable telemetry
			"toolkit.telemetry.archive.enabled" = false;
			"toolkit.telemetry.bhrPing.enabled" = false;
			"toolkit.telemetry.cachedClientID" = "";
			"toolkit.telemetry.enabled" = false;
			"toolkit.telemetry.firstShutdownPing.enabled" = false;
			"toolkit.telemetry.hybridContent.enabled" = false;
			"toolkit.telemetry.newProfilePing.enabled" = false;
			"toolkit.telemetry.prompted" = 2;
			"toolkit.telemetry.rejected" = true;
			"toolkit.telemetry.reportingpolicy.firstRun" = false;
			"toolkit.telemetry.server" = "";
			"toolkit.telemetry.shutdownPingSender.enabled" = false;
			"toolkit.telemetry.unified" = false;
			"toolkit.telemetry.unifiedIsOptIn" = false;
			"toolkit.telemetry.updatePing.enabled" = false;
			"datareporting.healthreport.service.enabled" = false;
			"datareporting.healthreport.uploadEnabled" = false;
			"datareporting.policy.dataSubmissionEnabled" = false;

			# Fingerprinting Prefs
			"device.sensors.ambientLight.enabled" = false;
			"device.sensors.enabled" = false;
			"device.sensors.motion.enabled" = false;
			"device.sensors.orientation.enabled" = false;
			"device.sensors.proximity.enabled" = false;
			"dom.battery.enabled" = false;
			"dom.event.clipboardevents.enabled" = false;
			"dom.private-attribution.submission.enabled" = false;
			"media.video_stats.enabled" = false;

			# Privacy Settings
			#"network.http.referer.spoofSource" = true;
			#"network.dns.disablePrefetchFromHTTPS" = true;
			#"network.dns.disablePrefetch" = true;
			#"network.http.speculative-parallel-limit" = 0;
			#"network.predictor.enable-prefetch" = false;
			#"network.predictor.enabled" = false;
			#"network.prefetch-next" = false;
			#"network.trr.mode" = 5;
			#"privacy.donottrackheader.enabled" = true;
			#"privacy.donottrackheader.value" = 1;
			#"privacy.query_stripping" = true;
			#"privacy.trackingprotection.cryptomining.enabled" = true;
			#"privacy.trackingprotection.enabled" = true;
			#"privacy.trackingprotection.fingerprinting.enabled" = true;
			#"privacy.trackingprotection.pbmode.enabled" = true;
			#"privacy.usercontext.about_newtab_segregation.enabled" = true;
			#"security.ssl.disable_session_identifiers" = true;
			#"signon.autofillForms" = false;
			#"webgl.renderer-string-override" = " ";
			#"webgl.vendor-string-override" = " ";

			# Extensions
			"extensions.FirefoxMulti-AccountContainers@mozilla.whiteList" = "";
			"extensions.TemporaryContainers@stoically.whiteList" = "";
			"extensions.getAddons.cache.enabled" = false;
			"extensions.getAddons.showPane" = false;
			"extensions.greasemonkey.stats.optedin" = false;
			"extensions.greasemonkey.stats.url" = "";
			"extensions.pocket.enabled" = false;
			"extensions.shield-recipe-client.api_url" = "";
			"extensions.shield-recipe-client.enabled" = false;
			"extensions.webservice.discoverURL" = "";

			# Generic User Agent
			"general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.3";

			# No autoplay
			"media.autoplay.default" = 0;
			"media.autoplay.enabled"  = false;

			# No encrypted media
			"media.eme.enabled" = false;
			"media.gmp-widevinecdm.enabled" = false;
			"browser.eme.ui.enabled" = false;





		};
	};


}
