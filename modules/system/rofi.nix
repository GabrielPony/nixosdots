{ pkgs,config, ... }:
{
  # home.packages = (with pkgs; [ rofi ]);
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
  };

  xdg.configFile."rofi/config.rasi".text = ''
    configuration{
      modi: "run,drun,window";
      lines: 5;
      cycle: false;
      font: "JetBrainsMono NF Bold 15";
      show-icons: true;
      icon-theme: "Papirus-dark";
      terminal: "kitty";
      drun-display-format: "{icon} {name}";
      location: 0;
      disable-history: true;
      hide-scrollbar: true;
      display-drun: " Apps ";
      display-run: " Run ";
      display-window: " Window ";
      /* display-Network: " Network"; */
      sidebar-mode: true;
      sorting-method: "fzf";
    }

    @theme "custom"

    element-text, element-icon , mode-switcher {
      background-color: inherit;
      text-color:       inherit;
    }

    window {
      height: 600px;
      width: 900px;
      border: 2px;
      lavenderor: @lavender;
      background-color: @base;
      border-radius: 12px;
    }

    mainbox {
      background-color: @base;
    }

    inputbar {
      children: [prompt,entry];
      background-color: @surface0;
      border-radius: 5px;
      padding: 0px;
    }

    prompt {
      background-color: @green;
      padding: 4px;
      text-color: @surface0;
      border-radius: 3px;
      margin: 10px 0px 10px 10px;
    }

    textbox-prompt-colon {
      expand: false;
      str: ":";
    }

    entry {
      padding: 6px;
      margin: 10px 10px 10px 5px;
      text-color: @text;
      background-color: @base;
      border-radius: 3px;
    }

    listview {
      border: 0px 0px 0px;
      padding: 6px 0px 0px;
      margin: 10px 0px 0px 6px;
      columns: 3;
      background-color: @base;
      cycle: true;
    }

    element {
      padding: 8px;
      margin: 0px 10px 4px 4px;
      background-color: @base;
      text-color: @text;
    }

    element-icon {
      size: 28px;
    }

    element selected {
      background-color:  @surface1 ;
      text-color: @subtext0;
      border-radius: 3px;
    }

    mode-switcher {
      spacing: 0;
    }

    button {
      padding: 10px;
      background-color: @surface0;
      text-color: @overlay0;
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }

    button selected {
      background-color: @base;
      text-color: @green;
    }
  '';
}

