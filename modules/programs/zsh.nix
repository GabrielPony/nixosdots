{ pkgs, inputs, config, ... }:
let
  zsh-config = inputs.dotfiles.packages.${pkgs.stdenv.hostPlatform.system}.zsh-config;
in
{
  programs.fzf.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" ];
      custom = "$HOME/.config/.oh-my-zsh/custom"; # 自定义目录
      theme = "powerlevel10k/powerlevel10k";
    };
    initContent = ''
# This will add to .zshrc
ZSH_CUSTOM="$HOME/.config/.oh-my-zsh/custom"
ZSH_THEME="powerlevel10k/powerlevel10k"

P10K_FILE=$HOME/.config/.oh-my-zsh/custom/themes/.p10k.zsh
[[ ! -f $P10K_FILE ]] || source $P10K_FILE

# terminal color
if [[ -n $TMUX ]]; then
  export TERM=tmux-256color
  if [[ -n "$NVIM" ]]; then
    # 1. Disable bracketed paste mode which can cause echo issues in nested terminals
    # unset zle_bracketed_paste
    # 2. Disable ZSH line editor initialization to prevent input processing conflicts
    # DISABLE_LINE_INIT=true
    # 3. Disable automatic terminal title updates to avoid output interference
    DISABLE_AUTO_TITLE=true
fi
else
  export TERM=xterm-256color
fi
# set nvim toggleterm
if [ -n "$NVIM" ]; then
  PROMPT='$ '
fi
export FZF_DEFAULT_OPTS="
	--color=bg:-1,bg+:-1,gutter:-1
	--color=fg:#d0d0d0,fg+:#ffffff,hl:#5f87af,hl+:#5fffff
	--color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
	--color=marker:#87ff00,spinner:#af5fff,header:#87afaf
	--border=rounded
	--height=40%
	--layout=reverse
	--preview-window=border-rounded
"
# config for direnv
eval "$(direnv hook zsh)"
    '';

    # initExtraFirst = ''
    #   unset tmux
    #   DISABLE_MAGIC_FUNCTIONS=true
    #   export "MICRO_TRUECOLOR=1"
    # '';

    shellAliases = {
      # record = "wf-recorder --audio=alsa_output.pci-0000_08_00.6.analog-stereo.monitor -f $HOME/Videos/$(date +'%Y%m%d%H%M%S_1.mp4')";

      # Utils
      code = "codium";
      py = "python";
      icat = "kitten icat";

      l = "eza --icons  -a --group-directories-first -1"; #EZA_ICON_SPACING=2
      ll = "eza --icons  -a --group-directories-first -1 --no-user --long";
      tree = "eza --icons --tree --group-directories-first";

      # Nixos
      cdnix = "cd ~/nixos-config && codium ~/nixos-config";
      ns = "nix-shell --run zsh";
      nix-shell = "nix-shell --run zsh";
      nix-flake-update = "sudo nix flake update ~/Documents/new_nixos#";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
    };
  };

  programs.zsh.dotDir = "${config.home.homeDirectory}/.config/zsh";
  home.packages = (with pkgs; [
    zsh
    fzf
    zoxide
    zsh-config
  ]);

  home.file.".config/.oh-my-zsh".source = "${zsh-config}/config";
}
