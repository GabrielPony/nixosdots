{ stdenv, fetchFromGitHub, pkgs, ... }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "nvim-config";
  version = "1.0.0";

  lazyvim-src  = fetchFromGitHub {
    owner = "LazyVim";
    repo = "starter";
    rev = "main";  # 您也可以指定具体的 commit hash
    sha256 = "sha256-/I8ln+40Dy0CAKDMygdOwrN//TJwam8U+QJd2e4Xl1U=";  # 首次运行会提示正确的 sha256，替换这个值
  };

  custom-src = fetchFromGitHub {
    owner = "GabrielPony";  # 替换为你的 GitHub 用户名
    repo = "dotfiles";  # 替换为你的仓库名
    rev = "main";  # 可以是分支名、tag 或 commit hash
    sha256 = "sha256-P9MRP79013x14KGlky+UrjRHRMuS0uKoGpcmuOV3Zqc=";#首次运行会提示正确的 hash
  };

  src = lazyvim-src;

  # 不需要构建阶段
  dontBuild = true;

  # 安装阶段
  installPhase = ''
    mkdir -p $out/config
    rm -r ./LICENSE
    rm -r ./README.md
    cp -r ./* $out/config/
    for f in ${custom-src}/nvim/custom/config/*; do
        filename=$(basename "$f")
        cat "$f" >> "$out/config/lua/config/$filename"
    done
    cp -r ${custom-src}/nvim/custom/plugins/* $out/config/lua/plugins/
  '';
}
