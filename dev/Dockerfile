FROM docker.io/debian:12

ENV TERM=xterm-256color

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes \
    bash-completion \
    build-essential \
    curl \
    git \
    iproute2 \
    iputils-ping \
    jq \
    less \
    locales \
    man \
    openssh-client \
    sudo \
    tree \
    wget

RUN sed --in-place 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN useradd --create-home --shell /bin/bash dev && \
    echo 'dev ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev

RUN curl --silent --show-error --location https://git.io/g-install \
    | sh -s -- bash -y && \
    .go/bin/go install golang.org/x/tools/gopls@latest && \
    .go/bin/go install golang.org/x/tools/cmd/goimports@latest

RUN curl --silent --show-error --fail https://sh.rustup.rs \
    | sh -s -- -y && \
    . "$HOME/.cargo/env" && \
    rustup default stable && \
    rustup component add rust-analyzer

RUN git clone https://github.com/helix-editor/helix .helix && \
    cd .helix && \
    git checkout 23.05 && \
    . "$HOME/.cargo/env" && \
    cargo install --path helix-term --locked && \
    echo 'export HELIX_RUNTIME="$HOME/.helix/runtime"' >> "$HOME/.bashrc" && \
    hx --grammar fetch && \
    hx --grammar build

WORKDIR /home/dev
COPY helix .config/helix

CMD ["/bin/bash", "--login"]
