FROM gitpod/workspace-full:latest
USER root
# Install util tools.
RUN apt-get update \
 && apt-get install -y \
  apt-utils \
  sudo \
  git \
  less \
  wget \
  tree \
  curl \
  graphviz

RUN mkdir -p /workspace/data \
    && chown -R gitpod:gitpod /workspace/data
  
RUN mkdir /home/gitpod/.conda

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
    
RUN chown -R gitpod:gitpod /opt/conda \
    && chmod -R 777 /opt/conda \
    && chown -R gitpod:gitpod /home/gitpod/.conda \
    && chmod -R 777 /home/gitpod/.conda

RUN /bin/sh -c curl -fsSL https://get.nextflow.io | bash  && mv nextflow /usr/local/bin/  && chmod 755 /usr/local/bin/nextflow  && nextflow info  && rm /.nextflow/maven.xml

USER root

RUN apt-get clean
