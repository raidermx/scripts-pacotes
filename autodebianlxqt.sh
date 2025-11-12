#!/bin/bash
set -e

# Variáveis - ajuste conforme seu disco
EFI_PART=/dev/sda1
BOOT_PART=/dev/sda2
ROOT_PART=/dev/sda3
DEBIAN_MIRROR=http://deb.debian.org/debian
DEBIAN_RELEASE=stable

# Instalar pacotes necessários no Live CD
apt update
apt install -y debootstrap btrfs-progs gdisk grub-efi-amd64 linux-image-amd64 wget gnupg

# Formatar partições
mkfs.vfat -F32 $EFI_PART
mkfs.ext4 $BOOT_PART
mkfs.btrfs -f $ROOT_PART

# Criar subvolumes
mount $ROOT_PART /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
umount /mnt

# Montar estrutura
mount -o subvol=@ $ROOT_PART /mnt
mkdir -p /mnt/{boot,home,var,log,tmp}
mount -o subvol=@home $ROOT_PART /mnt/home
mount -o subvol=@var $ROOT_PART /mnt/var
mount -o subvol=@log $ROOT_PART /mnt/log
mount -o subvol=@tmp $ROOT_PART /mnt/tmp
mount $BOOT_PART /mnt/boot
mkdir -p /mnt/boot/efi
mount $EFI_PART /mnt/boot/efi

# Instalar sistema base
debootstrap $DEBIAN_RELEASE /mnt $DEBIAN_MIRROR

# Preparar chroot
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

chroot /mnt /bin/bash <<EOF
echo debian > /etc/hostname
apt update
apt install -y grub-efi-amd64 linux-image-amd64 locales systemd-sysv

# Configurar locale para Português-Brasil
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
update-locale LANG=pt_BR.UTF-8
export LANG=pt_BR.UTF-8

# Instalar suporte completo ao idioma
apt install -y fonts-dejavu fonts-liberation fonts-noto hunspell-pt-br aspell-pt-br myspell-pt-br

# Configurar fstab
UUID_ROOT=$(blkid -s UUID -o value $ROOT_PART)
UUID_BOOT=$(blkid -s UUID -o value $BOOT_PART)
UUID_EFI=$(blkid -s UUID -o value $EFI_PART)

cat <<FSTAB > /etc/fstab
UUID=$UUID_ROOT / btrfs subvol=@,defaults,noatime,compress=zstd 0 0
UUID=$UUID_ROOT /home btrfs subvol=@home,defaults,noatime,compress=zstd 0 0
UUID=$UUID_ROOT /var btrfs subvol=@var,defaults,noatime,compress=zstd 0 0
UUID=$UUID_ROOT /log btrfs subvol=@log,defaults,noatime,compress=zstd 0 0
UUID=$UUID_ROOT /tmp btrfs subvol=@tmp,defaults,noatime,compress=zstd 0 0
UUID=$UUID_BOOT /boot ext4 defaults 0 2
UUID=$UUID_EFI /boot/efi vfat defaults 0 1
FSTAB

# Instalar GRUB
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Debian
update-grub

# Instalar LXQt + Xorg + gerenciador de login
apt install -y task-lxqt-desktop lightdm xorg

# Kit gráfico (drivers básicos)
apt install -y firmware-linux mesa-utils xserver-xorg-video-all

# Kit de áudio
apt install -y pulseaudio pavucontrol alsa-utils

# Kit multimídia (codecs e players)
apt install -y vlc ffmpeg gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
               gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav

# Navegador Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list
apt update
apt install -y google-chrome-stable

# Programas gráficos
apt install -y gimp inkscape krita blender digikam rawtherapee

# Extras úteis
apt install -y network-manager

# Criar senha do root
echo "root:root" | chpasswd

# Criar usuário padrão 'user' com senha 'user'
useradd -m -s /bin/bash user
echo "user:user" | chpasswd
adduser user sudo
EOF

echo "✅ Instalação concluída com LXQt, idioma pt-BR completo, kits gráficos/áudio/multimídia, Google Chrome, programas gráficos e usuários configurados!"
umount -R /mnt
