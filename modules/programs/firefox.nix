{ pkgs, config, inputs, lib,... }:
let

in
{
  # stylix.targets.firefox.profileNames = [ "default" ];
  programs.firefox = {
    enable = true;
  };
    # policies = {
    #   DisableTelemetry = true;
    #   DisableFirefoxStudies = true;
    #   DisablePocket = true;
    #   OverrideFirstRunPage = "";
    #   OverridePostUpdatePage = "";
    #   DontCheckDefaultBrowser = true;
    #   # DisableFirefoxAccounts = true;
    #   # DisableAccounts = true;
    #   "AutofillAddressEnabled" = false;
    #   "AutofillCreditCardEnabled" = false;
    #   Preferences = {
    #     "extensions.autoDisableScopes" = 0; # Automatically enable extensions
    #     "extensions.update.enabled" = false;
    #   };
    # };

  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--gtk-version=4"
      "--ozone-platform=wayland"
    ];
  };

  # home.activation.cleanFirefoxSearch = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
  #     $DRY_RUN_CMD rm -f "$HOME/.mozilla/firefox/default/search.json.mozlz4"
  #     $DRY_RUN_CMD rm -f "$HOME/.mozilla/firefox/default/search.json.mozlz4.hm-backup"
  #   '';
}
