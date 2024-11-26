{ stdenv, uconfig, fetchFromGitHub, ... }:
let
repo-owner = uconfig.custom.repo.owner;
repo-name = uconfig.custom.repo.repo;
repo-rev = uconfig.custom.repo.rev;
repo-sha256 = uconfig.custom.repo.sha256;
in
stdenv.mkDerivation rec {
  pname = "nvim-config";
  version = "1.0.0";

  custom-src = fetchFromGitHub {
    owner = "${repo-owner}";
    repo = "${repo-name}";
    rev = "${repo-rev}";
    sha256 = "${repo-sha256}";
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
