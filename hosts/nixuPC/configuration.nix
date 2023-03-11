{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.timeout = 1;

  #Networking
  networking.hostName = "nixos";  


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

    #Bluetooth
    hardware.bluetooth = {
    enable = true;
    hsphfpd.enable = false;
     settings = {
      General = {
       Enable = "Source,Sink,Media,Socket";
       };
      }; 
     };


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

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

  # Display servers and window managers
  services.xserver.enable = true;
  services.getty.autologinUser = "pablo";
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "pablo";

  # DWM
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/pablo/.config/suckless/dwm ;});
      })
  ];

  

  environment.systemPackages = with pkgs; [
  neovim
  starship
  wget
  fish
  kitty
  rofi
  pcmanfm
  git
  bat
  lsd
  pywal
  slstatus
 ];

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
   };
  
  nixpkgs.config.allUnfree = true; 

  system.stateVersion = "22.11";

  # Nvidia
   services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

}
