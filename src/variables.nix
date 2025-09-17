{
  config,
  lib,
  ...
}: {
  config.var = {
    hostname = "nixyowo";
    username = "lavender";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos";

    keyboardLayout = "us";

    timeZone = "America/Los_Angeles";
    defaultLocale = "en_US.UTF-8";

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}