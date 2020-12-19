FROM archlinux/base:latest

RUN echo -e "Server = http://mirrors.cat.net/archlinux/\$repo/os/\$arch\nServer = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/\$repo/os/\$arch\nServer = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/\$repo/os/\$arch\n" > /etc/pacman.d/mirrorlist && \
    pacman -Syu --noconfirm --needed \
        base-devel \
        git \
        go && \
    useradd -m user && \
    echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER user
WORKDIR /home/user
RUN git clone --depth 1 https://aur.archlinux.org/yay-bin.git yay
WORKDIR /home/user/yay
RUN makepkg -si --noconfirm && \
    curl -O https://linux.dropbox.com/fedora/rpm-public-key.asc && \
    gpg --import rpm-public-key.asc && \
    rm -f rpm-public-key.asc
WORKDIR /home/user
ENV PKGDEST=/home/user/pkg
