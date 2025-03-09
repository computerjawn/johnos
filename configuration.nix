{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./wooting.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
  # Firewall Configuration
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;

  boot.loader.grub.enable = false;
  # Time and Locale
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.john = {
    isNormalUser = true;
    description = "john";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "input"
      "plugdev"
    ];
    packages = with pkgs; [ kdePackages.kate ];
    shell = pkgs.fish;
  };

  # Display and Desktop
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "john";
  services.displayManager.defaultSession = "plasmax11";

  # Programs and Services
  programs.fish.enable = true;
  programs.steam.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.ratbagd.enable = true;
  services.printing.enable = true;
  services.fstrim.enable = true;
  programs.gamemode.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    helix
    mumble
    prismlauncher
    docker
    git
    firefox
    vscode
    rocmPackages.rocm-smi
    (pkgs.btop.override {
      rocmSupport = true;
    })
  ];

  # System State Version
  system.stateVersion = "24.05";
}
