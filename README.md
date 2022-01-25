## Setup

- Install Nix 2.4+ and enable flakes (`echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf`)
- For home-manager setups: `nix run home-manager --no-write-lock-file -- switch --flake <system>` where `<system>` is e.g `'.#axel_mbp16'`
  - On subsequent runs `home-manager` should be available without having to `nix run` it
- For NixOS (nixpi): `nixos-rebuild switch --flake '.#nixpi'`

## Update Packages

```sh
nix flake update
home-manager switch --flake '.#axel_mbp16'
```

## Performance tweaks

```bash
for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done
```

References:

- https://carlosbecker.com/posts/speeding-up-zsh
- https://htr3n.github.io/2018/07/faster-zsh/
- https://blog.jonlu.ca/posts/speeding-up-zsh
