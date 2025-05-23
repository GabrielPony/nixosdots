{ stdenv, config, fetchFromGitHub, ... }:
let
repo = config.user.custom.repo;
repo-owner = repo.owner;
repo-name = repo.name;
repo-rev = repo.rev;
repo-sha256 = repo.sha256;
in
stdenv.mkDerivation rec {
  pname = "tmux-config";
  version = "1.0.0";

  ohmytmux-src = fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "4cb811769abe8a2398c7c68c8e9f00e87bad4035"; # 您也可以指定具体的 commit hash
    sha256 = "sha256-e7Ymv3DD7FY2i7ij9woZ6o/edJGbEfm2K8wrD2H43Yk=";
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
