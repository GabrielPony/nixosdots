{ stdenv, fetchFromGitHub, pkgs, ... }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "zsh-config";
  version = "1.0.0";

  zsh-src  = fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "master";  # 您也可以指定具体的 commit hash
    sha256 = "sha256-HchVESSo01R7u3F0PP645Xm0QeKbHsBjvqigmNdXDFQ=";  # 首次运行会提示正确的 sha256，替换这个值
  };

  p10k-src = fetchFromGitHub {
    owner = "GabrielPony";  # 替换为你的 GitHub 用户名
    repo = "p10k";  # 替换为你的仓库名
    rev = "main";  # 可以是分支名、tag 或 commit hash
    sha256 = "sha256-J+Cmo9/ftM7XelANyaguxRDQGvtArLXQa+r/bDfV5VI=";  # 首次运行会提示正确的 hash
  };

  src = zsh-src;

  # 不需要构建阶段
  dontBuild = true;

  # 安装阶段
  installPhase = ''
    mkdir -p $out/config/custom/themes/powerlevel10k
    rm -r ./LICENSE
    rm -r ./README.md
    cp -r ${p10k-src}/.p10k.zsh $out/config/custom/themes/
    cp -r ./* $out/config/custom/themes/powerlevel10k
  '';
}
