{ stdenv, fetchFromGitHub, pkgs, ... }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "nvim-config";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "LazyVim";
    repo = "starter";
    rev = "main";  # 您也可以指定具体的 commit hash
    sha256 = "sha256-/I8ln+40Dy0CAKDMygdOwrN//TJwam8U+QJd2e4Xl1U=";  # 首次运行会提示正确的 sha256，替换这个值
  };

#   custom-src = fetchFromGitHub {
#     owner = "azabiong";  # 替换为你的 GitHub 用户名
#     repo = "vim-highlighter";  # 替换为你的仓库名
#     rev = "main";  # 可以是分支名、tag 或 commit hash
#     sha256 = "sha256-6dAYR/NB6OmHU6JqusMXR9txj3AQm2jBql4mgOT15J4=";  # 首次运行会提示正确的 hash
#   };

  # 不需要构建阶段
  dontBuild = true;

  # 安装阶段
  installPhase = ''
    echo "LazyVim 源目录: ${src}"
    
    mkdir -p $out/config
    cp -r ./* $out/config/

  '';
}
