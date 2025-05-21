{ config, pkgs, lib, ... }:

{
  imports = [
    # This gets added from the flake output, so don't include manually unless testing
    # <nixos-hardware/raspberry-pi/4>
  ];

  # Required for Raspberry Pi boot
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_rpi4;

  hardware.enableRedistributableFirmware = true;

  # Enables the Raspberry Pi 4 specific hardware modules
  hardware.raspberry-pi."4".enable = true;

  networking.hostName = "rpi4";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  # Enable SSH for headless setup
  services.openssh.enable = true;

  # Optional: enable passwordless root login via SSH (⚠️ for testing only)
  users.users.root.openssh.authorizedKeys.keys = [
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCrHioL3LKPsaU+wflE7GVO1sKj1qKh7vPjRFZ/dayC noe"
  ];

  # Basic user
  users.users.pi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "nixos";  # ⚠️ Change later or use hashedPassword
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    tmux
  ];

  # Reduce writes to SD card
  services.journald.extraConfig = ''
    Storage=volatile
  '';

  system.stateVersion = "25.05";  # Or your current system version
}
