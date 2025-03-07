{ fdupes
, buildFHSEnv
, fetchzip
, icoutils
, imagemagick
, jdk17
, lib
, makeDesktopItem
, stdenvNoCC
}:

let
  iconame = "STM32CubeMX";
  package = stdenvNoCC.mkDerivation rec {
    pname = "stm32cubemx";
    version = "6.11.1";

    src = fetchzip {
      url = "https://sw-center.st.com/packs/resource/library/stm32cube_mx_v${builtins.replaceStrings ["."] [""] version}-lin.zip";
      hash = "sha256-By9T43GLM1J63TkRi3kl05h1RflBorU1QHgYOrXQ9N0=";
      stripRoot = false;
    };

    nativeBuildInputs = [ fdupes icoutils imagemagick ];
    desktopItem = makeDesktopItem {
      name = "STM32CubeMX";
      exec = "stm32cubemx --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
      desktopName = "STM32CubeMX";
      categories = [ "Development" ];
      icon = "stm32cubemx";
      comment = meta.description;
      terminal = false;
      startupNotify = false;
      mimeTypes = [
        "x-scheme-handler/sgnl"
        "x-scheme-handler/signalcaptcha"
      ];
    };

    buildCommand = ''
      mkdir -p $out/{bin,opt/STM32CubeMX,share/applications}

      cp -r $src/MX/. $out/opt/STM32CubeMX/
      chmod +rx $out/opt/STM32CubeMX/STM32CubeMX

      cat << EOF > $out/bin/${pname}
      #!${stdenvNoCC.shell}
      ${jdk17}/bin/java -jar $out/opt/STM32CubeMX/STM32CubeMX
      EOF
      chmod +x $out/bin/${pname}

      icotool --extract $out/opt/STM32CubeMX/help/${iconame}.ico
      fdupes -dN . > /dev/null
      ls
      for size in 16 24 32 48 64 128 256; do
        mkdir -pv $out/share/icons/hicolor/"$size"x"$size"/apps
        if [ $size -eq 256 ]; then
          mv ${iconame}_*_"$size"x"$size"x32.png \
            $out/share/icons/hicolor/"$size"x"$size"/apps/${pname}.png
        else
          convert -resize "$size"x"$size" ${iconame}_*_256x256x32.png \
            $out/share/icons/hicolor/"$size"x"$size"/apps/${pname}.png
        fi
      done;

      cp ${desktopItem}/share/applications/*.desktop $out/share/applications
    '';

    meta = with lib; {
      description = "A graphical tool for configuring STM32 microcontrollers and microprocessors";
      longDescription = ''
        A graphical tool that allows a very easy configuration of STM32
        microcontrollers and microprocessors, as well as the generation of the
        corresponding initialization C code for the Arm® Cortex®-M core or a
        partial Linux® Device Tree for Arm® Cortex®-A core), through a
        step-by-step process.
      '';
      homepage = "https://www.st.com/en/development-tools/stm32cubemx.html";
      sourceProvenance = with sourceTypes; [ binaryBytecode ];
      license = licenses.unfree;
      maintainers = with maintainers; [ angaz wucke13 ];
      platforms = [ "x86_64-linux" ];
    };
  };
  in
  buildFHSEnv {
    inherit (package) pname version meta;
    runScript = "${package.outPath}/bin/stm32cubemx";
    targetPkgs = pkgs:
      with pkgs; [
        alsa-lib
        at-spi2-atk
        cairo
        cups
        dbus
        expat
        glib
        gtk3
        libdrm
        libGL
        libudev0-shim
        libxkbcommon
        mesa
        nspr
        nss
        pango
        xorg.libX11
        xorg.libxcb
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
      ];
     extraInstallCommands = ''
      cp -rf ${package}/share $out/
    '';
}
