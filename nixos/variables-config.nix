{ lib, ... }: {
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
    user = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
