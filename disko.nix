{
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
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
            name = "nixenc";
            size = "100%";
            content = {
              type = "luks";
              passphrase = "your_passphrase_here";
              settings = {
                allowDiscards = true;
              }
              content = {
                type = "lvm_pv";
                vg = "root_vg";
              }
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
                };              };
            };
          };
        };
      };
    };
  };
}
