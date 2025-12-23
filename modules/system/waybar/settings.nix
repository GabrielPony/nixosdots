{ ... }:
{
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    height = 30;
    margin-top = 10;
    margin-bottom = 0;
    margin-left = 10;
    margin-right = 10;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
    ];
    modules-center = [
      "custom/playerctl"
      "clock"
    ];
    modules-right = [
      "tray"
      "custom/sep"
      "cpu"
      "memory"
      "disk"
      "pulseaudio"
      "battery"
      "network"
      "custom/notification"
    ];
    clock = {
      calendar = {
        format = { today = "<span color='#b4befe'><b><u>{}</u></b></span>"; };
      };
      format = "   {:%H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "   {:%d/%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "󰣇";
        urgent = "";
        default = "󰣇";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [ ];
      };
    };
    memory = {
      format = "󰟜  {}%";
      format-alt = "󰟜  {used} GiB"; # 
      interval = 2;
    };
    cpu = {
      format = "   {usage}%";
      format-alt = "   {avg_frequency} GHz";
      interval = 2;
    };
    disk = {
      # path = "/";
      format = "󰋊  {percentage_used}%";
      interval = 2;
    };
    network = {
      format-wifi = "   {signalStrength}%";
      format-ethernet = "󰀂";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰖪 ";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon}  {volume}%";
      format-muted = "   {volume}%";
      format-icons = {
        default = [ " " ];
      };
      scroll-step = 5;
      on-click = "pamixer -t";
      on-click-right = "pavucontrol";
    };
    battery = {
      format = "{icon}  {capacity}%";
      format-icons = [ " " " " " " " " " " ];
      format-charging = "  {capacity}%";
      format-full = "  {capacity}%";
      format-warning = "  {capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };

    "custom/sep" = {
      format = "<span foreground='#585b70'> | </span>";
      tooltip = false;
    };
    "custom/launcher" = {
      format = "";
      on-click = "rofi";
      tooltip = "false";
    };

    "custom/playerctl" = {
      format = "{icon}  <span>{text}</span>";
      return-type = "json";
      max-length = 55;
      exec = ''playerctl -a metadata --format '{"text": "  {{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F || true'';
      on-click-middle = "playerctl previous";
      on-click = "playerctl play-pause";
      on-click-right = "playerctl next";
      format-icons = {
        Paused = "<span foreground='#6dd9d9'></span>";
        Playing = "<span foreground='#82db97'></span>";
      };
    };

    "custom/notification" = {
      tooltip = false;
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>   ";
        none = "   ";
        dnd-notification = "<span foreground='red'><sup></sup></span>   ";
        dnd-none = "   ";
        inhibited-notification = "<span foreground='red'><sup></sup></span>   ";
        inhibited-none = "   ";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>   ";
        dnd-inhibited-none = "   ";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };
}
