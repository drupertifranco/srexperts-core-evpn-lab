# Usa Ubuntu como base
FROM ubuntu:22.04

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias y containerlab
RUN apt-get update && apt-get install -y \
    curl \
    iproute2 \
    iputils-ping \
    net-tools \
    gnupg2 \
    ca-certificates \
    sudo \
    bash \
    tcpdump \
    bridge-utils \
    git \
    && curl -sL https://get.containerlab.dev | bash \
    && apt-get clean

# Crear usuario no root
RUN useradd -ms /bin/bash clab && echo "clab ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER clab
WORKDIR /home/clab

# Copiar el laboratorio dentro de la imagen
COPY --chown=clab:clab labs/ /home/clab/labs/

# Comando por defecto: abrir bash
CMD ["/bin/bash"]
