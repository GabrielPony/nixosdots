{ pkgs,config, ... }:
{
  # home.packages = (with pkgs; [ rofi ]);
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
  };

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,window";
      lines: 8;
      cycle: false;
      font: "JetBrainsMono NF Bold 14";
      show-icons: true;
      icon-theme: "Papirus-dark";
      terminal: "kitty";
      drun-display-format: "{name}";
      window-format: "{w} · {c} · {t}";
      location: 0;
      disable-history: false;
      hide-scrollbar: true;
      sidebar-mode: true;
      display-drun: "   Apps   ";
      display-window: "   Window ";
      sorting-method: "fzf";
    }

    @theme "custom"

    * {
        border: 0;
        margin: 0;
        padding: 0;
        spacing: 0;
    }

    window {
      width: 45%;
      transparency: "real";
      background-color: @background;
      border: 1px;
      border-color: @blue;
      border-radius: 10px;
    }

    mainbox {
      background-color: transparent;
      children: [ inputbar, listview ];
    }

    inputbar {
      children: [ prompt, entry ];
      background-color: transparent;
      border-radius: 0px;
      margin: 20px 20px 10px 20px;
    }

    prompt {
      background-color: transparent;
      text-color: @blue;
      padding: 10px 15px;
      border-radius: 8px 0px 0px 8px;
    }

    entry {
      background-color: transparent;
      text-color: @foreground;
      placeholder: "Search...";
      padding: 10px 15px;
      border-radius: 0px 8px 8px 0px;
    }

    listview {
      background-color: transparent;
      columns: 2;
      lines: 8;
      margin: 10px 20px 20px 20px;
      spacing: 5px;
    }

    element {
      background-color: transparent;
      text-color: @foreground;
      padding: 8px 10px;
      border-radius: 6px;
    }

    element alternate.normal {
      background-color: transparent;
    }
    element alternate.active {
      background-color: transparent;
    }
    element normal.normal {
      background-color: transparent;
    }
    element normal.active {
      background-color: transparent;
    }
    element-icon {
      background-color: transparent;
      size: 24px;
      margin: 0 10px 0 0;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      vertical-align: 0.5;
    }

    element selected {
      background-color: @blue;
      text-color: @background;
    }

    mode-switcher {
      margin: 0px 100px 20px 100px;
      background-color: transparent;
      spacing: 20px;
    }
    '';
}

