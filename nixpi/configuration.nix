{ config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "se";
  # useXkbConfig = true; # use xkb.options in tty.
  #};

  time.timeZone = "Europe/Stockholm";

  # https://search.nixos.org/options?channel=unstable&show=system.autoUpgrade.flake&from=0&size=50&sort=relevance&type=packages&query=system.autoupgrade
  system.autoUpgrade.enable = false;

  programs.zsh.enable = true;
  programs.ssh.startAgent = true;

  users = {
    mutableUsers = false;
    users = {
      axel = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        home = "/home/axel";
        hashedPassword =
          "$y$j9T$4R7nkA77ZhIHj2mEk4hpN.$oUVs1c6.SeDiFrmR0KEjNNZjTfoDv01wg0bNRY9dEO/";
        description = "Axel Larsson";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTagaZ9d/J57JmYQja2uUiDj6PKctEJCvHg/vhkEuIN axel@mbp_14"
        ];
      };
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # packages to install
  environment.systemPackages = with pkgs; [ vim ];
  environment.variables = { EDITOR = "vim"; };

  networking.hostName = "nixpi";

  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  hardware.enableRedistributableFirmware = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
