{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  config.programs.thunderbird = {
    # https://home-manager-options.extranix.com/?query=programs.thunderbird.&release=master
    enable = true;
    profiles.lavender = {
      isDefault = true;
    };
  };
}