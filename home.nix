{
  pkgs,
  ...
}:

{
  home = {
    # PUT YOUR USERNAME HERE
    username = "sam";
    # PUT YOUR HOME DIRECTORY HERE
    homeDirectory = "/home/sam";

    packages = with pkgs; [
      # PUT ANY PACKAGES YOU WANT INSTALLED HERE
    ];

    # SET THIS TO THE SAME NUMBER AS IN CONFIGURATION.NIX AND NEVER CHANGE IT
    stateVersion = "25.05";

    shellAliases = {
      nixconfig = "nano /etc/nixos/configuration.nix";
      nixhome = "nano /etc/nixos/home.nix";
      nixbuild = "bash /etc/nixos/rebuild.sh";
      nixupdate = "bash /etc/nixos/update.sh";
    };

  };

  programs = {
    git = {
      enable = true;
      userEmail = "samibinol@icloud.com";
      userName = "sammy";
    };
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
    };
    zsh.oh-my-zsh = {
      enable = true;
      plugins = [ ];
      theme = "mikeh";
    };
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.obs-vaapi ];
    };
  };
}
