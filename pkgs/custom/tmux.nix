{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "tmux-config";
  version = "1.0.0";

  ohmytmux-src = fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "master"; # 您也可以指定具体的 commit hash
    sha256 = "sha256-4PQQyNREi4LHDKbj0nn1pcVJC53Efxt6tJyaTKtt9us=";
  };

  tmux-src = fetchFromGitHub {
    owner = "GabrielPony"; # 替换为你的 GitHub 用户名
    repo = "dotfiles"; # 替换为你的仓库名
    rev = "main"; # 可以是分支名、tag 或 commit hash
    sha256 = "sha256-IJavNVrG7zttwRu3fiYjdZLFkBZs5E0BHrYhZTf631U=";
  };

  src = ohmytmux-src;

  # 不需要构建阶段
  dontBuild = true;

  # 安装阶段
  installPhase = ''
    mkdir -p $out/config
    rm -r ./README.md
    cp -r ${tmux-src}/tmux/.tmux.conf.local $out/config
    cp -r ./.tmux.conf $out/config
  '';
}
