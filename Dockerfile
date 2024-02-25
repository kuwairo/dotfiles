FROM ghcr.io/void-linux/void-glibc-full

ENV TERM=alacritty

RUN echo 'en_US.UTF-8 UTF-8' > /etc/default/libc-locales && \
    xbps-reconfigure --force glibc-locales

RUN xbps-install --sync --update --yes xbps && \
    xbps-install --sync --update --yes \
    alacritty-terminfo \
    base-devel \
    bash-completion \
    file \
    git \
    go \
    helix \
    jq \
    man-db \
    man-pages \
    ncurses \
    sudo \
    tokei \
    tree \
    wget \
    xtools

RUN useradd --create-home --shell /bin/bash dev && \
    echo 'dev ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev

COPY --chown=dev:dev helix .config/helix

RUN go install golang.org/x/tools/gopls@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    echo 'PATH=$HOME/go/bin:$PATH' >> .bash_profile

CMD ["/bin/bash", "--login"]
