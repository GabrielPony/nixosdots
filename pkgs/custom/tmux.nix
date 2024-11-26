{ stdenv, uconfig, fetchFromGitHub, ... }:
let
repo-owner = uconfig.custom.repo.owner;
repo-name = uconfig.custom.repo.repo;
repo-rev = uconfig.custom.repo.rev;
repo-sha256 = uconfig.custom.repo.sha256;
in
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
    owner = "${repo-owner}";
    repo = "${repo-name}";
    rev = "${repo-rev}";
    sha256 = "${repo-sha256}";
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
