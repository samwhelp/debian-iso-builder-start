#!/usr/bin/env bash


##
## ## Create Live ISO
##

#genisoimage -V DEMO-OS -o demo.iso ISO-temp/
genisoimage -r -loliet-long -V DEMO-OS -o demo.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -cache-inodes -T -eltorito-alt-boot -b boot/grub/efi.img -no-emul-boot amd64/
