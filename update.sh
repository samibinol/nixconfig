cd /etc/nixos/
sudo nix flake update || { printf "\n\e[1;31m>>>> Failed to update NixOS <<<<\e[0m\n"; exit 1; }
sudo nixos-rebuild switch || { printf "\n\e[1;31m>>>> Failed to build NixOS <<<<\e[0m\n"; exit 1; }
cd ~
sudo nixos-rebuild switch || { printf "\n\e[1;31m>>>> Failed to build NixOS <<<<\e[0m\n"; exit 1; }
