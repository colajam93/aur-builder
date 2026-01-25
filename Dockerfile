FROM archlinux:base-devel AS paru

RUN pacman -Syy --noconfirm && pacman -S --noconfirm jq

RUN curl -L -o paru.tar.zst \
    "$(curl -sS https://api.github.com/repos/Morganamilo/paru/releases \
        | jq '[.[0].assets[] | select(.name | endswith("-x86_64.tar.zst"))] | sort_by(.name)[0].browser_download_url' -r)"
RUN tar xvf paru.tar.zst

RUN curl -L -o yay.tar.gz \
    "$(curl -sS https://api.github.com/repos/Jguer/yay/releases \
        | jq '[.[0].assets[] | select(.name | endswith("_x86_64.tar.gz"))] | sort_by(.name)[0].browser_download_url' -r)"
RUN tar --strip-components=1 -xvf yay.tar.gz

FROM archlinux:base-devel

COPY mirrorlist /etc/pacman.d/
RUN pacman -Syu --noconfirm --needed git && \
    useradd -m -d /home/builder builder && \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER builder
WORKDIR /home/builder
COPY --from=paru /paru /usr/local/bin/paru
COPY --from=paru /yay /usr/local/bin/yay
ENV PKGDEST=/home/builder/pkg
RUN \
    # dropbox https://aur.archlinux.org/packages/dropbox#comment-676597
    curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import - && \
    # force delete lock file to avoid hanging verifing
    rm -f .gnupg/public-keys.d/pubring.db.lock
ENTRYPOINT ["/usr/local/bin/paru"]
