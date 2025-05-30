{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos-desktop"; # Define your hostname.
    firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  services.pipewire = {
    configPackages = [
        (pkgs.writeTextDir "share/pipewire/pipewire.conf.d/10-high-sample-rate.conf" ''
          context.properties = {
            default.clock.allowed-rates = [ 192000 384000 768000 ]
            default.clock.rate = 192000
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
  services.displayManager.autoLogin.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: 
        # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
        # lacking many basic packages needed by most software.
        # Therefore, we need to add them manually.
        #
        # pkgs.appimageTools provides basic packages required by most software.
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses
          # Feel free to add more packages here if needed.
        ]
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
    }))

    wget
    git
    gh
    tidal-hifi
    fastfetch
    zsh    
    telegram-desktop
    appimage-run
    obs-studio
    vesktop
    helvum
    discord-rpc
    icu
    orca-slicer
    alsa-utils
    prismlauncher
    ncdu
    pam_u2f
    yubioath-flutter
    yubikey-touch-detector
    yubikey-personalization-gui
    yubikey-personalization
    libu2f-host
    yubico-pam
    nheko
    mullvad-vpn
    arduino-ide
    python3Full
  ];
  
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  programs.gamemode.enable = true;
  
  programs.adb.enable = true;
  services.flatpak.enable = true;
  
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    sddm.u2fAuth = true;
    sddm.unixAuth = false;
    sudo.unixAuth = false;
    login.unixAuth = false;
  };

  security.pam.u2f = {
    control = "sufficient";
    enable = true;
    settings.authfile = pkgs.writeText "u2f-auth-file" ''sam:XZbpybn52rrT0lm1oCFnbj1Tf4mv7vG7FJEv5mBvhpSu/IrgUlW5N8YLesl9/+Be0ojCrizkEq8I6ZgGOiIAsw==,mWR1bh1dmjbd87Wr+dsDKDAGXiwI5m7T49lHSp1M/zW6b1PqfEPh0EnFdFVrXSlyl9j7lP9IarT7618knttCQA==,es256,+presence'';
  };

  services.udev.extraRules = ''
      ACTION=="remove",\
       ENV{ID_BUS}=="usb",\
       ENV{ID_MODEL_ID}=="0407",\
       ENV{ID_VENDOR_ID}=="1050",\
       ENV{ID_VENDOR}=="Yubico",\
       RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';  
}
