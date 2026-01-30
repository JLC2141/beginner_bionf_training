# FROM defines the base docker image. 
# The 'as' keyword lets you name the following stage. We use `app` for the production image
FROM ubuntu:focal as app

ARG FASTQC_VER="0.12.1"

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
RUN apt-get update && apt-get install -y --no-install-recommends locales \
    unzip \
    wget \
    perl \
    default-jre \
    ca-certificates \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen \
    procps && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*


# install fastqc. Make /data for use as a working dir
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VER}.zip && \
    unzip fastqc_v${FASTQC_VER}.zip && \
    rm fastqc_v${FASTQC_VER}.zip && \
    chmod +x FastQC/fastqc
    #mkdir /data

RUN useradd -m -s /bin/bash vscode 

# set PATH and working directory
ENV PATH="${PATH}:/FastQC/"
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
    
#WORKDIR /data
WORKDIR /workspace
