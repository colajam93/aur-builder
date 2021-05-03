FROM archlinux:base-devel

COPY mirrorlist /etc/pacman.d/
RUN pacman -Syu --noconfirm --needed \
        git && \
    useradd -m -d /home/builder builder && \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER builder
WORKDIR /home/builder
RUN curl -LO 'https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz' && \
    tar xvf yay-bin.tar.gz && \
    cd yay-bin && \
    makepkg -si --noconfirm && \
    cd && \
    rm -rf yay-bin yay-bin.tar.gz
RUN curl -O https://linux.dropbox.com/fedora/rpm-public-key.asc && \
    gpg --import rpm-public-key.asc && \
    rm -f rpm-public-key.asc
ENV PKGDEST=/home/builder/pkg
ENTRYPOINT ["/usr/bin/yay"]
