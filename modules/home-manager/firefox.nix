{ config, lib, pkgs, self, inputs, ... }:

{
    programs.firefox = {
      enable = true;

      profiles.default = {
        extensions =
        with inputs.firefox-addons.packages."x86_64-linux"; # ROUGH AS FUCK IMPLEMENTATION
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
        settings = {
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
      };
    }; 
}



