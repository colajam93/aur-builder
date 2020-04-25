FROM archlinux/base:latest
MAINTAINER colajam93 <https://github.com/colajam93>

RUN echo -e "Server = http://mirrors.cat.net/archlinux/\$repo/os/\$arch\nServer = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/\$repo/os/\$arch\nServer = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/\$repo/os/\$arch\n" > /etc/pacman.d/mirrorlist && \
    pacman -Syu --noconfirm --needed \
        base-devel \
        git \
        go &> /dev/null && \
    useradd -m user && \
    echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER user
WORKDIR /home/user
RUN git clone --depth 1 https://aur.archlinux.org/yay.git &> /dev/null
WORKDIR /home/user/yay
RUN makepkg -si --noconfirm &> /dev/null
WORKDIR /home/user
ENV PKGDEST=/home/user/pkg
