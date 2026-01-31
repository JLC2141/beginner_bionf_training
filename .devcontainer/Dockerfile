# FROM defines the base docker image. 
# The 'as' keyword lets you name the following stage. We use `app` for the production image
FROM ubuntu:focal as app

ARG FASTQC_VER="0.12.1"
ARG SPADES_VER="4.2.0"
ARG SRATOOLKIT_VER="3.3.0"

# metadata
LABEL base.image="ubuntu:focal"
LABEL dockerfile.version="1"
LABEL software="FASTQC"
LABEL software.version="${FASTQC_VER}"
LABEL description="A quality control analysis tool for high throughput sequencing data"
LABEL website="https://www.bioinformatics.babraham.ac.uk/projects/fastqc/"
LABEL website.code.repo="https://github.com/s-andrews/FastQC/"
LABEL license="https://github.com/s-andrews/FastQC/blob/master/LICENSE.txt"
LABEL maintainer="Abigail Shockey"
LABEL maintainer.email="abigail.shockey@slh.wisc.edu"
LABEL maintainer2="Curtis Kapsak"
LABEL maintainer2.email="kapsakcj@gmail.com"
LABEL maintainer3="Pooja Gupta"
LABEL maintainer3.email="biopooja@gmail.com"

# install dependencies; cleanup apt garbage
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-distutils \
    wget \
    pigz \
    unzip \
    perl \
    default-jre \
    ca-certificates \
    libgomp1 \
    procps && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10


# install fastqc
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VER}.zip && \
    unzip fastqc_v${FASTQC_VER}.zip && \
    rm fastqc_v${FASTQC_VER}.zip && \
    chmod +x FastQC/fastqc
    
#install fastp
RUN wget http://opengene.org/fastp/fastp.0.23.4 && \
    mv fastp.0.23.4 fastp && \
    chmod a+x ./fastp && \
    mv ./fastp /usr/local/bin/

#install spades
RUN wget -q https://github.com/ablab/spades/releases/download/v${SPADES_VER}/SPAdes-${SPADES_VER}-Linux.tar.gz && \
    tar -xzf SPAdes-${SPADES_VER}-Linux.tar.gz && \
    rm -r SPAdes-${SPADES_VER}-Linux.tar.gz

#install SRAtoolkit
RUN wget -q https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${SRATOOLKIT_VER}/sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz &&\
    tar -xvf sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz && rm sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz


RUN useradd -m -s /bin/bash vscode 

#CMD ["spades.py", "--help"]

# set PATH and working directory
ENV PATH="${PATH}:/FastQC/"
ENV PATH="${PATH}:/SPAdes-${SPADES_VER}-Linux/bin"
ENV PATH="$PATH:/sratoolkit.${SRATOOLKIT_VER}-ubuntu64/bin"
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

#WORKDIR /data
WORKDIR /workspace
