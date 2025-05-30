{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos-laptop"; # Define your hostname.
    firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    isNormalUser = true;
    description = "sammy";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Disable automatic login for the user.
  services.displayManager.autoLogin.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    
    
  ];
    
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  programs.gamemode.enable = true;
  
  services.flatpak.enable = true;
  
  
}
