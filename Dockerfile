FROM ghcr.io/void-linux/void-glibc-full

ENV TERM=xterm-kitty

RUN echo 'en_US.UTF-8 UTF-8' > /etc/default/libc-locales && \
    xbps-reconfigure --force glibc-locales

RUN xbps-install --sync --update --yes && \
    xbps-install --yes \
    base-devel \
    file \
    fish-shell \
    git \
    go \
    helix \
    jq \
    kitty-terminfo \
    man-db \
    man-pages \
    ncurses \
    rustup \
    sudo \
    tokei \
    tree \
    wget \
    xtools

RUN useradd --create-home --shell /usr/bin/fish dev && \
    echo 'dev ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev

RUN rm .bash* .inputrc
COPY --chown=dev:dev fish .config/fish
COPY --chown=dev:dev helix .config/helix

RUN go install golang.org/x/tools/gopls@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    fish --command='fish_add_path go/bin'

RUN rustup-init -y --no-modify-path --component rust-analyzer && \
    fish --command='fish_add_path .cargo/bin'

CMD ["/usr/bin/fish", "--login"]
