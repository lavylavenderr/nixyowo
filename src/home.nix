{
    pkgs,
    config,
    ...
}: {
    imports = [
        ./variables.nix
        ./git
        ./git/signing.nix
    ];

    home = {
      inherit (config.var) username;
      homeDirectory = "/home/" + config.var.username;

      packages = with pkgs; [
        # Applications
        firefox
        ayugram-desktop
        vscode
        vesktop
        vlc
        mpv
        spotify
        cloudflare-warp
        darktable
        obsidian
        _1password-gui
        _1password-cli


        # Development
        go
        bun
        nodejs
        python3
        jq
        just
        pnpm
        air
        duckdb
        rustup
        typescript
        eslint
        cargo

        # Utils
        zip
        unzip
        optipng
        jpegoptim
        pfetch
        btop
        fastfetch
        bat
        inotify-tools
        killall
        libnotify

        # Just cool
        peaclock
        cbonsai
        pipes
        cmatrix
      ];

      stateVersion = "24.05";
      file.".face.icon" = {source = ./profile_picture.jpg;};
    };

    programs.home-manager.enable = true;
}
