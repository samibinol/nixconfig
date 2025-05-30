{
  pkgs,
  ...
}:

{
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
  };
}
