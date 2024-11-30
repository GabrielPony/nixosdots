{ pkgs, config, inputs,... }: {

  _module.args = { inherit inputs; };

  imports = [
    ../nixos/variables.nix

    # themes
    # ./themes/stylix/default.nix
    # Programs
    ./programs/packages.nix
    ./programs/kitty.nix
    ./programs/tmux.nix
    ./programs/nvim.nix
    ./programs/zsh.nix
    ./programs/wechat.nix
    ./programs/discord.nix
    ./programs/gedit.nix
    ./programs/spicetify.nix
    ./programs/qutebrowser/qutebrowser.nix
    ./programs/cava.nix
    ./programs/vscodium.nix
    # ./programs/shell
    # ./programs/fetch
    ./programs/git.nix
    # ./programs/spicetify
    # ./programs/nextcloud
    # ./programs/yazi
    # ./programs/thunar
    ./programs/lazygit.nix
    # ./programs/nh
    ./programs/firefox.nix
    # ./programs/server-page

    # Scripts
    # ./scripts # All scripts

    # System (Desktop environment like stuff)
    ./system/fuzzel.nix
    ./system/anyrun.nix
    ./system/waybar/default.nix
    ./system/hyprland/default.nix
    ./system/scripts/scripts.nix
    ./system/gtk/gtk.nix
    ./system/swaync/swaync.nix
    # ./system/hypridle
    # ./system/hyprlock
    # ./system/hyprpanel
    # ./system/hyprpaper
    # ./system/gtk
    # ./system/wofi
    # ./system/batsignal
    # ./system/zathura
    # ./system/mime
    # ./system/udiskie
    # ./system/clipman
    # ./system/tofi

    #./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    #   packages = with pkgs; [
    #     # Apps
    #     discord # Chat
    #     bitwarden # Password manager
    #     vlc # Video player
    #     blanket # White-noise app
    #
    #     # Dev
    #     go
    #     nodejs
    #     python3
    #     jq
    #     figlet
    #     just
    #
    #     # Utils
    #     zip
    #     unzip
    #     optipng
    #     pfetch
    #     pandoc
    #     btop
    #
    #     # Just cool
    #     peaclock
    #     cbonsai
    #     pipes
    #     cmatrix
    #     # cava
    #
    #     # Backup
    #     vscode
    #   ];

    # Import my profile picture, used by the hyprpanel dashboard
    # file.".profile_picture.png" = { source = ./profile_picture.png; };

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
