{ inputs, uconfig, host, ... }: {
    _module.args = {
    inherit inputs uconfig host;
  };
  imports = [
    ./wechat.nix
    ./rider.nix # C# JetBrain editor
    ./fcitx.nix
    ./gedit.nix
    ./aseprite/aseprite.nix # pixel art editor
    ./audacious/audacious.nix # music player
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./cava.nix # audio visualizer
    ./discord.nix # discord with catppuccin theme
    ./floorp/floorp.nix # firefox based browser
    ./fuzzel.nix # launcher
    ./gaming.nix # packages related to gaming
    ./git.nix # version control
    ./gtk.nix # gtk theme
    ./hyprland # window manager
    ./kitty.nix # terminal
    ./swaync/swaync.nix # notification deamon
    ./micro.nix # nano replacement
    ./nvim.nix # neovim editor
    ./packages.nix # other packages
    ./retroarch.nix
    ./scripts/scripts.nix # personal scripts
    ./spicetify.nix # spotify client
    ./starship.nix # shell prompt
    ./swaylock.nix # lock screen
    ./vscodium.nix # vscode forck
    ./waybar # status bar
    ./tmux.nix
    ./zsh.nix # shell
  ];
  # ++ [(import ./steam.nix)];
  # ++ [(import ./unity.nix)];
}
