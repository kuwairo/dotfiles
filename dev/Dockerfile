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
    rsync \
    rustup \
    tree \
    wget

RUN useradd --create-home --shell /bin/bash dev && \
    echo 'dev ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev

RUN go install golang.org/x/tools/gopls@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    echo 'export PATH="$PATH:$HOME/go/bin"' >> .bashrc

RUN rustup default stable && \
    rustup component add rust-analyzer

RUN curl --proto '=https' --tlsv1.2 --silent --show-error --fail \
    https://get-ghcup.haskell.org | \
    BOOTSTRAP_HASKELL_NONINTERACTIVE="Y" \
    BOOTSTRAP_HASKELL_GHC_VERSION="latest" \
    BOOTSTRAP_HASKELL_CABAL_VERSION="latest" \
    BOOTSTRAP_HASKELL_INSTALL_NO_STACK="Y" \
    BOOTSTRAP_HASKELL_INSTALL_HLS="Y" \
    BOOTSTRAP_HASKELL_ADJUST_BASHRC="P" \
    /bin/sh && \
    . .ghcup/env && \
    cabal install --installdir="$HOME/.cabal/bin" ormolu

COPY --chown=dev:dev helix .config/helix

CMD ["/bin/bash", "--login"]
