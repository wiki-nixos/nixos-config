{ config, lib, pkgs, self, inputs, ... }:

{
    programs.firefox = {
      enable = true;

      profiles.default = {
        extensions =
        with inputs.firefox-addons.packages."x86_64-linux";
          [
            darkreader
            firefox-color
            violentmonkey
            ublock-origin
            clearurls
            user-agent-string-switcher
            search-by-image
            stylus
            tabliss
            disable-javascript
            buster-captcha-solver
            localcdn
        ];

        search.engines = {
         "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
          };
          
         "NixOS Wiki" = {
          urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
           iconUpdateURL = "https://wiki.nixos.org/favicon.png";
           updateInterval = 24 * 60 * 60 * 1000; # every day
           definedAliases = [ "@nw" ];
         };

        "HomeLab SearXNG" = {
          urls = [{ template = "https://192.168.50.52/search?q={searchTerms}"; }];
           iconUpdateURL = "https://searx.axsl.xyz/favicon.ico";
           updateInterval = 24 * 60 * 60 * 1000; # every day
           definedAliases = [ "@hs" ];
         };

        "Binking Box SearXNG" = {
          urls = [{ template = "https://search.bleedingbox.dev/search?q={searchTerms}"; }];
           iconUpdateURL = "https://searx.axsl.xyz/favicon.ico";
           updateInterval = 24 * 60 * 60 * 1000; # every day
           definedAliases = [ "@bs" ];
         };

        "Ansel SearXNG" = {
          urls = [{ template = "https://searx.axsl.xyz/search?q={searchTerms}"; }];
           iconUpdateURL = "https://searx.axsl.xyz/favicon.ico";
           updateInterval = 24 * 60 * 60 * 1000; # every day
           definedAliases = [ "@as" ];
         };
        };

        settings = {

          # Use My Silly SearXNG Instance
          "browser.search.defaultenginename" = "HomeLab SearXNG";
          "browser.search.order.1" = "HomeLab SearXNG";

          # Tell websites not to sell or share my data
          "privacy.globalprivacycontrol.enabled" = true;

          # Send websites a “Do Not Track” request
          "privacy.donottrackheader.enabled" = true;

          # Remember Search and Form History
          "browser.formfill.enable" = false;

          # OCSP
          "security.OCSP.enabled" = true;

          # Enable HTTPS-Only Mode in All Windows
          "dom.security.https_only_mode" = true;

          # DNS
          "network.trr.mode" = "3";

          # Don't save passwords.
          "signon.rememberSignons" = false;

          # Don't show a warning when opening about:config. I know what I'm doing!
          "browser.aboutConfig.showWarning" = false;

          # Disable telemetry.
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.unified" = false;

          # Disable Firefox Pocket.
          "extensions.pocket.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;

          # Disable Firefox View.
          "browser.tabs.firefox-view" = false;

          # Disable Firefox account features
          "identity.fxaccounts.enabled" = false;

          # Enable dark theme.
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "browser.theme.content-theme" = 2;
          "browser.theme.toolbar-theme" = 2;
        };

        search = {
         force = true;
         default = "HomeLab SearXNG";
         order = [ "Homelab SearXNG" ];
       };
      };
    }; 
}



