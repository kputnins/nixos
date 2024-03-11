# Switching to grub

When switching to grub bootloader

- Use the `efibootmgr` package to delete the systemd-boot entry
- Deleted these directories:
  - /boot/EFI/systemd
  - /boot/EFI/Linux
  - /boot/EFI/nixos
  - /boot/loader

**Optional** - Add [rEFInd](https://nixos.wiki/wiki/REFInd) as a second fallback bootloader
