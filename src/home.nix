{
    pkgs,
    config,
    inputs,
    ...
}: {
    imports = [
        ./variables.nix
        ./programs/git.nix
        ./programs/thunderbird.nix
        ./programs/kitty
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
        darktable
        distrobox
        docker-compose
        prismlauncher

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
        typescript
        eslint
        cargo
        dotenvx # i need to decrypt my envs somehow lol
        

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
      file.".face" = {source = ./profile_picture.jpg;};
      file."face.png" = {source = ./profile_picture.jpg;};
    };

    programs.home-manager.enable = true;
}
