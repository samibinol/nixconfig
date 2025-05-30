{ pkgs, ... }:

{
  networking = {
    hostName = "nixos-laptop"; # Define your hostname.
  };

  services.pipewire = {
    configPackages = [
        (pkgs.writeTextDir "share/pipewire/pipewire.conf.d/10-high-sample-rate.conf" ''
          context.properties = {
            default.clock.allowed-rates = [ 32000 44100 48000 96000 192000 ]
            default.clock.rate = 44100
          }
        '')
      ];
  };

  environment.systemPackages = with pkgs; [
  ];
    
  programs.gamemode.enable = true;
}
