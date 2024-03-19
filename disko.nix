{
  device ? throw "Set this to your disk device, e.g. sda",
  ...
}: {
  disko.devices = {
    disk.main = {
      device = "/dev/${device}";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "11G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          nixenc = {
            size = "100%";
            label = "nixenc";
            content = {
              name = "nixenc";
              type = "luks";
              passwordFile = "/tmp/secret.key";
              settings = {
                allowDiscards = true;
              };
              content = {
                type = "lvm_pv";
                vg = "root_vg";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      root_vg = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "/root" = {
                  mountOptions = ["subvol=root" "compress=zstd" "noatime"];
                  mountpoint = "/";
                };

                "/persist" = {
                  mountOptions = ["subvol=persist" "compress=zstd" "noatime"];
                  mountpoint = "/persist";
                };

                "/nix" = {
                  mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
                  mountpoint = "/nix";
                };
                "/home" = {
                  mountOptions = ["home=" "compress=zstd" "noatime"];
                  mountpoint = "/home";
                };
              };
            };
          };
        };
      };
    };
  };
}
