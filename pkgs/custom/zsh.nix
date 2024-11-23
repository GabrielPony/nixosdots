{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "zsh-config";
  version = "1.0.0";

  zsh-src = fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "master"; # 您也可以指定具体的 commit hash
    sha256 = "sha256-0ORdl9kLhfaDPhUZU3bxd3oVqB7hsrZPZ2wUPVu48gY="; # 首次运行会提示正确的 sha256，替换这个值
  };

  p10k-src = fetchFromGitHub {
    owner = "GabrielPony"; # 替换为你的 GitHub 用户名
    repo = "dotfiles"; # 替换为你的仓库名
    rev = "main"; # 可以是分支名、tag 或 commit hash
    sha256 = "sha256-P9MRP79013x14KGlky+UrjRHRMuS0uKoGpcmuOV3Zqc="; # 首次运行会提示正确的 hash
  };

  src = zsh-src;

  # 不需要构建阶段
  dontBuild = true;

  # 安装阶段
  installPhase = ''
    mkdir -p $out/config/custom/themes/powerlevel10k
    rm -r ./LICENSE
    rm -r ./README.md
    cp -r ${p10k-src}/zsh/.p10k.zsh $out/config/custom/themes/
    cp -r ./* $out/config/custom/themes/powerlevel10k
  '';
}
