# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.legacy_340 ];

  networking = {
    hostName = "qwerty"; # Define your hostname
    # not needed when networkmanager is enabled
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;

    # Open ports in the firewall
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether
    # firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {

    # Modesetting is required
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  };

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Load nvidia driver for Xorg and Wayland
      videoDrivers = [ "nvidia" ];

      # the display manager handles user login
      # compatible with wayland: gdm, sddm
      # displayManager.sddm.enable = true;
      displayManager.gdm.enable = true;

      # Enable the GNOME Desktop Environment
      # desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "es";
        variant = "";      
      };
    };

    libinput = {
      # Enable touchpad support (enabled default in most desktopManager)
      enable = true;
      touchpad = {
        naturalScrolling = false;
      };
      mouse = {
        accelProfile = "flat";
      };
    };
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.neverbot = {
    shell = pkgs.bash;
    isNormalUser = true;
    description = "neverbot";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # firefox
      # thunderbird
    ];
  };

  # no need to input password when this user uses sudo
  security.sudo.extraRules = [
    {
      users = [ "neverbot" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  environment = {
    shells = with pkgs; [ bash ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default
    systemPackages = with pkgs; [
      vim 
      neovim
      nano 
      wget 
      git 
      gh           # github cli 
      lynx         # text-mode web browser
      lshw         # hardware info
      pciutils     # hardware info
      inxi         # hardware info

      home-manager # user environment management

      # from here, wayland + hyprland related packages
      wayland      # wayland protocol
      hyprland     # hyprland window manager
      kitty        # default terminal in hyprland
      firefox-wayland
      waybar       # app bar
      hyprpaper    # wallpapers
      wl-clipboard # clipboard manager
      wtype        # type special characters
      grim         # screenshot
      slurp        # select area for screenshot
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    waybar = {
      enable = true;
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerdfonts
      font-awesome
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # home manager configuration
  home-manager.users.neverbot = { pkgs, ... }: {

    home = {
      # same as above
      stateVersion = "23.11";
      packages = with pkgs; [ 
        onefetch     # git repository summary
        neofetch     # system info
        htop         # system monitor
        btop         # htop alternative
        pamixer      # pulseaudio mixer
      ];

      username = "neverbot";
      homeDirectory = "/home/neverbot";
 
      # copy some needed config files
      file = {
        ".config/hypr" = {
          source = /home/neverbot/dotfiles/nixos/hypr;
          recursive = true;
        };
        ".config/waybar" = {
          source = /home/neverbot/dotfiles/nixos/waybar;
          recursive = true;
        };
      };
    };

    # as we are copying the hyprland.config in home.file, there is no need
    # for any other particular user configuration here
    # we can comment it to avoid a warning saying this is maybe an error
    # because it is empty
    # wayland.windowManager.hyprland = {
      # enable = true;
      # extraConfig = ''
      #   ${builtins.readFile /home/neverbot/dotfiles/nixos/hyprland.conf}
      # '';
    # };

    programs = {
      home-manager = {
        enable = true;
        path = "$HOME/.config/home-manager";
      };

      git = {
        enable = true;
        userName = "neverbot";
        userEmail = "ivan@neverbot.com";
      };

      kitty = {
        enable = true;
        settings = {
          # padding vertical and horizontal
          window_padding_width = "5 10";
        };
      };
    };
  };
}
