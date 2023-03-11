{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #Bootloader
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.timeout = 1;

  #Networking
  networking.hostName = "NixPC";  


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

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
   
  # Pipewire
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
      };
    };

  # Enabling bluetooth
  hardware = {
    bluetooth.enable = true;
  };


  # enable starship inside bash interactive session (useful when using nix-shell).
  programs.bash.promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';

  # Configure keymap in X11
  services = {
    xserver = {
    layout = "es";
    xkbVariant = "";
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "pablo";
   }; 

   # enables blueman for bluetooth
    blueman.enable = true;
 
   # automount usb
    devmon.enable = true;
    udisks2.enable = true;
 
};
  # Configure console keymap
  console.keyMap = "es";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pablo = {
    isNormalUser = true;
    description = "pablo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users = {
  defaultUserShell = pkgs.fish;};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Dconf
  programs.dconf.enable = true;

  # DWM
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/pablo/.config/suckless/dwm ;});
      })
  ];


  environment.systemPackages = with pkgs; [
  neovim
  firefox
  starship
  helix
  fish
  kitty
  rofi
  pcmanfm
  blueman
  git
  discord
  bat
  htop
  tree
  lsd
  pywal
  font-manager
  slstatus
];

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
   };  

  nixpkgs.config.allUnfree = true; 

  system.stateVersion = "22.11";

  # fontconfig configuration
  fonts = {
    fonts = with pkgs; [
      inter
      lato
      maple-mono
      maple-mono-NF
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      iosevka
      jetbrains-mono
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };

      subpixel.lcdfilter = "default";

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Maple Mono NF"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
  };

}
