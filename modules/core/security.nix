{ ... }: 
{
  security.rtkit.enable = true;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
  # security.pam.services.swaylock = { };
  security.pam.services.hyprlock = {};
}
