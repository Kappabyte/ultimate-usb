#!/bin/sh

DEPS=("wget" "nixos-install" "ventoy" "7za" "refind-install")
MISSING_DEPS=""

# Ensure dependencies are installed
for dep in ${DEPS[@]}; do
    if ! command -v $dep &> /dev/null; then
        MISSING_DEPS="$MISSING_DEPS \n * $dep"
    fi
done


if [[ $MISSING_DEPS != "" ]]; then
    echo -e "Ultimate USB is missing the following dependencies: $MISSING_DEPS"
    echo If you are using Nix, you can use the provided shell.nix to aquire the required packages.
    exit
fi

# Get user config data
clear
echo "Please enter a drive to install Ultimate USB to. Only enter the device name (ex: sda)"
lsblk
read -p "Device (ex: sda): " drive
echo "/dev/${drive}"
if [ ! -e /dev/${drive} ]; then
    echo "Invalid drive provided!"
    exit
fi


DRIVE_SIZE=$(( $(lsblk -b --output SIZE -n -d /dev/${drive}) / 1073741824 ))
REMAINING_SIZE=$DRIVE_SIZE

# Ventoy Installation Size
echo
echo Enter the size of the root partion for NixOS. 
echo Enter 0 to disable the NixOS install.
echo Remaing space: ${DRIVE_SIZE}GB
read -p "NixOS root size (GB): " nixossize

REMAINING_SIZE=$(( $REMAINING_SIZE - $nixossize ))

echo
echo Enter the size of the storage partion. This is a Fat32 formatted partition for general data storage.
echo Enter 0 to disable the storage partition
echo Remaing space: ${REMAINING_SIZE}GB
read -p "Storage size (GB): " storagesize

REMAINING_SIZE=$(( $REMAINING_SIZE - $storagesize ))

echo
echo Enter the amount of disk space to be left unallocated.
echo The remaining space will be used for ventoy.
echo Remaing space: ${REMAINING_SIZE}GB
read -p "Unallocated size (GB): " unallocatedsize

vtoysize=$(( $REMAINING_SIZE - $unallocatedsize ))
vtoysize=$(( $vtoysize - 2 ))
vtoyextra=$(( $DRIVE_SIZE - $vtoysize ))

echo
echo Would you like to install Medicat?
echo At least 30GB of Ventoy space is required.
echo Ventoy Space: $vtoysize
if [ $vtoysize -lt 30 ]; then
    echo There is insufficient space to install Medicat.
    medicat=n
    read -p "(Press any key to continue)"
else
    read -p "(y/n)" medicat
fi

clear
echo
echo Beginning installation!
echo The drive /dev/${drive} will now be formatted!
echo Press Ctl+C to cancel!
echo

echo Installing Ventoy...
ventoy -I -r $((vtoyextra * 1024)) -g /dev/${drive}

sleep 5
mount /dev/disk/by-label/Ventoy ./ventoy --mkdir
mount /dev/disk/by-label/VTOYEFI ./ventoyefi --mkdir
# Install ventoy

if [[ $medicat == "y" ]]; then
    clear
    URL=https://mirror.fangshdow.trade/medicat-usb/MediCat%20USB%20v21.12/MediCat.USB.v21.12.7z
    FILE=$(basename $URL)

    # Download the medicat binary if it doesn't already exist
    if [ ! -f $FILE ]; then
        echo Downloading Medicat \($FILE\) from $URL
        wget $URL
    else
        echo Using existing Medicat file: $FILE
    fi
    
    echo Installing Medicat
    7za x $FILE -o./ventoy
fi

clear
echo Updating Ventoy Themes
mkdir ./ventoy/ventoy
mkdir ./ventoy/ventoy/theme
rm -rf ./ventoy/ventoy/theme/*
mkdir ./ventoy/ventoy/theme/legacy
mkdir ./ventoy/ventoy/theme/uefi

cp ventoy.json ./ventoy/ventoy/
cp -r ./grub-theme/src/* ./ventoy/ventoy/theme/legacy/
cp -r ./grub-theme/src/* ./ventoy/ventoy/theme/uefi/

rm -f ./ventoyefi/EFI/BOOT/BOOT*.EFI

clear
echo Creating Partitions
# Create partitions
(
    echo n # new partition
    echo # Partition Number
    echo # First Sector
    echo +1G
    echo t
    echo
    echo 1

    echo n # new partition
    echo # Partition Number
    echo # First Sector
    echo +${nixossize}G

    echo n # new partition
    echo # Partition Number
    echo # First Sector
    echo +${storagesize}G

    echo w
) | sudo fdisk /dev/${drive}

bootpart=$(fdisk -l /dev/${drive} -o device | tail -3 | head -1)
rootpart=$(fdisk -l /dev/${drive} -o device | tail -2 | head -1)
storepart=$(fdisk -l /dev/${drive} -o device | tail -1 | head -1)

# Create filesystems
mkfs.fat -F 32 -n usbboot $bootpart
mkfs.btrfs -f -L usbroot $rootpart
mkfs.fat -F 32 -n storage $storepart

# Mount filesystems
mount $rootpart ./mnt --mkdir

btrfs subvolume create ./mnt/root
btrfs subvolume create ./mnt/nix
btrfs subvolume create ./mnt/home

umount $rootpart

mount $rootpart -o subvol=root ./mnt --mkdir
mount $rootpart -o subvol=nix ./mnt/nix --mkdir
mount $rootpart -o subvol=home ./mnt/home --mkdir

mount $bootpart ./mnt/boot --mkdir
mount $storepart ./mnt/mnt/storage --mkdir

clear
echo Installing NixOS

mkdir ./mnt/home/usb
mkdir ./mnt/home/usb/nixos

cp -r ./nixos-config/* ./mnt/home/usb/nixos/

nixos-generate-config --root $(readlink -f ./mnt)
nixos-install --flake ./mnt/home/usb/nixos#usb --root $(readlink -f ./mnt)

mv ./mnt/boot/EFI/BOOT ./mnt/boot/EFI/GRUB
mv ./mnt/boot/EFI/GRUB/BOOTX64.EFI ./mnt/boot/EFI/GRUB/GRUB.EFI

clear
echo Installing rEFInd

refind-install --usedefault $bootpart
cp ./refind.conf ./mnt/boot/EFI/BOOT/refind.conf

umount ./mnt/mnt/storage
umount ./mnt/nix
umount ./mnt/home
umount ./mnt/boot
umount ./mnt
umount ./ventoy
umount ./ventoyefi

clear
echo Done!

