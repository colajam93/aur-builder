FROM archlinux/base:latest
MAINTAINER colajam93 <https://github.com/colajam93>

RUN pacman -Syu --noconfirm --needed \
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
