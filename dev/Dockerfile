FROM archlinux/archlinux:base-devel

ENV TERM xterm-256color

RUN pacman --sync --refresh --sysupgrade --noconfirm \
    bash-completion \
    git \
    go \
    helix \
    man-db \
    man-pages \
    openssh \
    rustup \
    tree \
    vi \
    wget

RUN echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/wheel && \
    useradd \
    --create-home \
    --groups wheel \
    --shell /bin/bash \
    --password deP1nOo9kBtdE \
    dev # dev:dev

USER dev
WORKDIR /home/dev

COPY helix .config/helix

RUN go install golang.org/x/tools/gopls@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    echo 'export PATH="$PATH:$HOME/go/bin"' >> .bash_profile

RUN rustup default stable && \
    rustup component add rust-analyzer

CMD ["/bin/bash", "--login"]
