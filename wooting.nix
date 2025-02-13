{pkgs,...}:{
  environment.systemPackages = with pkgs; [ 
    wootility 
  ];

  hardware.wooting.enable = true;
  services.udev.packages = with pkgs; [
    via
    qmk-udev-rules
    uhk-udev-rules
    openrgb
    wooting-udev-rules
  ];
}
