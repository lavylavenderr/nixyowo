{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  config.programs.thunderbird = {
    inherit (config.var) username;
    # https://home-manager-options.extranix.com/?query=programs.thunderbird.&release=master
    enable = true;
    profiles.${config.var.username} = {
      isDefault = true;
    };
  };
}