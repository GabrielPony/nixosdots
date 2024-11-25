{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "nvim-config";
  version = "1.0.0";

  custom-src = fetchFromGitHub {
    owner = "GabrielPony"; # 替换为你的 GitHub 用户名
    repo = "dotfiles"; # 替换为你的仓库名
    rev = "main"; # 可以是分支名、tag 或 commit hash
    sha256 = "sha256-K9A443WOXdonzSLxXYwztrVJA3kOtPirMMuS4MzFtP0=";
  };

  src = custom-src;

  # 不需要构建阶段
  dontBuild = true;

  # 安装阶段
  installPhase = ''
    mkdir -p $out/config
    rm -r ./README.md
    cp -r ./nvim/* $out/config/
  '';
}
