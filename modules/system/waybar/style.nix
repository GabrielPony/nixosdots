{ ... }:
let custom = {
    font = "Monaspice Nerd Font";
    font_size = "15px";
    font_weight = "bold";
    text_color = "#cdd6f4";
    secondary_accent= "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "11111B";
    opacity = "0.80";
};
in
{
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 10px;
        padding: 0;
        margin: 0;
        min-height: 0px;
        font-family: ${custom.font};
        font-weight: ${custom.font_weight};
        opacity: ${custom.opacity};
    }

    window#waybar {
        background: alpha(@base00, ${custom.opacity});
        border: 1px solid #45475a;
    }

    #workspaces {
        font-size: 18px;
        padding-left: 10px;
        padding-right: 10px;
    }

    #workspaces button {
        color: ${custom.text_color};
        border-radius: 1;
        padding: 0 6px;
    }

    #workspaces button.empty {
        color: #6c7086;
    }

    #workspaces button.active {
        color: #b4befe;
    }

    #cpu, #memory, #disk, #tray, #pulseaudio, #battery, #network, #clock, #custom-notification {
        font-size: ${custom.font_size};
        color: ${custom.text_color};
        padding: 0 8px;
        margin: 0 4px;
    }

    #tray {
        padding: 0 10px;
    }

    #custom-launcher {
        font-size: 20px;
        color: #b4befe;
        font-weight: ${custom.font_weight};
        padding-left: 10px;
        padding-right: 15px;
    }
  '';
  }
