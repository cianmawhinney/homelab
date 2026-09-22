FROM mcr.microsoft.com/devcontainers/base:3-ubuntu22.04@sha256:833a9eb9b48b57160531c9ea552d942d4d428ec58d76305d43f4976419b32173

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && curl -s https://fluxcd.io/install.sh | sudo bash \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        terraform \
        packer \
        apt-utils \
        build-essential \
        libffi-dev \
        libssl-dev \
        libyaml-dev \
        python3-dev \
        python3-setuptools \
        python3-pip \
        python3-yaml \
        xorriso \
    && pip3 install \
        ansible \
        yamllint \
        ansible-lint \
    && curl -L https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz | tar xz hcloud \
    && mv hcloud /usr/local/bin/ \
    && rm -rf /var/lib/apt/lists/*
