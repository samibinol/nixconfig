#!/usr/bin/env bash

sudo nixos-rebuild switch || { printf "\n\e[1;31m>>>> Failed to build NixOS <<<<\e[0m\n"; exit 1; }
git -C /etc/nixos add . || { printf "\n\e[1;31m>>>> Failed to 'git add .' <<<<\e[0m\n"; exit 1; }
git -C /etc/nixos commit -m "rebuild command issued" || { printf "\n\e[1;31m>>>> Failed to commit git <<<<\e[0m\n"; exit 1; }
git -C /etc/nixos  push || { printf "\n\e[1;31m>>>> Failed to push git <<<<\e[0m\n"; exit 1; }

printf "\n\e[1;32m>>>> NixOS successfully rebuilt <<<<\e[0m\n"
