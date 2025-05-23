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
   };
}
