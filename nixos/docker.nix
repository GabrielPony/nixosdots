{ config, ... }: {
  virtualisation.docker = {
    enable = true;
    # 自动清理未使用的镜像和容器
    autoPrune = {
      enable = true;
      dates = "weekly";
    };

    # 修改存储驱动
    # storageDriver = "overlay2";

    # 配置守护进程选项
    extraOptions = ''
      --dns 8.8.8.8 \
      --dns 114.114.114.114
    '';

    # 配置 docker 镜像加速
    daemon.settings = {
      "registry-mirrors" = [
        "https://docker.m.daocloud.io"
        "https://docker.1ms.run"
      ];
    };
  };



  users.users."${config.var.username}".extraGroups = [ "docker" ];
}
