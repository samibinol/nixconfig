{ pkgs, ... }:

{
  networking = {
    hostName = "nixos-desktop";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    configPackages = [
        (pkgs.writeTextDir "share/pipewire/pipewire.conf.d/10-high-sample-rate.conf" ''
          context.properties = {
            default.clock.allowed-rates = [ 192000 384000 768000 ]
            default.clock.rate = 192000
          }
        '')
      ];
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    #default.sa
  };
  programs.gamemode.enable = true;
  
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    sddm.u2fAuth = true;
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
