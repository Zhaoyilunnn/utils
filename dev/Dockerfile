ARG base_image=ubuntu:24.04

# Base image
FROM ${base_image}

ARG ip=0.0.0.0
ARG port=10810
# Setup proxy
RUN echo "alias set_proxy=\"export https_proxy=socks5://${ip}:${port} && export http_proxy=socks5://${ip}:${port}\"" >> /root/.bashrc
RUN echo "alias unset_proxy=\"unset http_proxy https_proxy\"" >> /root/.bashrc

# Install vim, git, curl
RUN apt-get update && \
    apt-get install -y vim git curl

# Install other utilities
# RUN apt-get -y install apt-file software-properties-common iproute2 iputils-ping

# Install latex (mainly used for matplotlib,
# see: https://stackoverflow.com/questions/11354149/python-unable-to-render-tex-in-matplotlib)
# RUN apt-get install -y dvipng texlive-latex-extra \
#     texlive-fonts-recommended cm-super

# Clean apt cache
RUN rm -rf /var/lib/apt/lists/*

ARG ip
ARG port
# Configuration of git
RUN git config --global http.proxy socks5://${ip}:${port} && \
    git config --global https.proxy socks5://${ip}:${port} && \
    git config --global user.name Zhaoyilunnn && \
    git config --global user.email dilved1014@gmail.com

# Install nodejs for coc-nvim
ARG ip
ARG port
RUN export https_proxy=socks5://${ip}:${port} \
    http_proxy=sockst://${ip}:${port} && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . /root/.bashrc && \
    nvm install 20

# vim-plug
ARG ip
ARG port
RUN export https_proxy=socks5://${ip}:${port} \
    http_proxy=sockst://${ip}:${port} && \
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy .vimrc to image
COPY .vimrc /root/.vimrc
COPY coc-settings.json /root/.vim/

# PlugInstall and quit vim
RUN vim -c "PlugInstall" -c "qa"
RUN export https_proxy=socks5://${ip}:${port} \
    http_proxy=sockst://${ip}:${port} && \
    . /root/.bashrc && \
    cd /root/.vim/plugged/coc.nvim && npm ci && cd -

# Set work dir
WORKDIR /root
