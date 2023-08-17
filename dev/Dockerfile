FROM docker.io/archlinux/archlinux:base-devel

ENV TERM=xterm-256color

RUN sed --in-place \
    '/NoExtract  = usr\/share\/man\/\* usr\/share\/info\/\*/d' \
    /etc/pacman.conf

RUN pacman --sync --refresh --sysupgrade --noconfirm \
    $(pacman --query | awk '{print $1}' | tr '\n' ' ') \
    bash-completion \
    git \
    go \
    helix \
    jq \
    man-db \
    man-pages \
    openssh \
    rustup \
    tree \
    wget

RUN useradd --create-home --shell /bin/bash dev && \
    echo 'dev ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev

COPY --chown=dev:dev helix .config/helix

RUN go install golang.org/x/tools/gopls@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    echo 'export PATH="$PATH:$HOME/go/bin"' >> .bashrc

RUN rustup default stable && \
    rustup component add rust-analyzer

CMD ["/bin/bash", "--login"]
