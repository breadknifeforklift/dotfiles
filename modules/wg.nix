{ pkgs, config, lib, ... }:
{
  options.wg.ip = lib.mkOption {
    type = lib.types.str;
    description = "the ip for the client interface";
  };

  config = {
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];

    # services.resolved.enable = true;
    networking.firewall.enable = false;
    # services.dnsmasq.enable = true;
    # networking.networkmanager.dns = "dnsmasq";

    networking.networkmanager.insertNameservers = [ "10.1.2.1" ];
    networking.wireguard.interfaces = {
      wg0 = {
        ips = [ config.wg.ip ];
        listenPort = 51820;
        privateKeyFile = "/home/sdober/wireguard-keys/private";

        # postSetup = ''${pkgs.dnsmasq}/bin/dnsmasq --server=/dober.design/10.1.2.1'';

        peers = [
          {
            publicKey = "MiX9IV/WA++tA+AGgP/xl4JZ7X/fmB0e9wyd/mLCtXk=";
            allowedIPs = [ "10.0.0.0/8" ];
            endpoint = "75.185.30.7:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
