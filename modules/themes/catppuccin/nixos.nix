{ pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin-nix.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;    # 全局启用
    flavor = flavor;  # 推荐 mocha (深色)，还有 latte, frappe, macchiato
    accent = basic-accent;  # 强调色：lavender, mauve, blue 等
    grub = {
      enable = true;
      flavor = flavor;
    }
  };

}
