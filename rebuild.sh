sudo nixos-rebuild switch
git -C /etc/nixos add .
git -C /etc/nixos commit -m "rebuild command issued"
git -C /etc/nixos  push
