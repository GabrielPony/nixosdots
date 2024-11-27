{ stdenv, uconfig, fetchFromGitHub, ... }:
let
repo-owner = uconfig.custom.repo.owner;
repo-name = uconfig.custom.repo.name;
repo-rev = uconfig.custom.repo.rev;
repo-sha256 = uconfig.custom.repo.sha256;
in
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
    owner = "${repo-owner}";
    repo = "${repo-name}";
    rev = "${repo-rev}";
    sha256 = "${repo-sha256}";
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
