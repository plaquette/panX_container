FROM debian:bullseye-slim

# install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git \
    bash \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# install miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /app/miniconda3 && \
    rm /tmp/miniconda.sh

#env variables for conda
ENV PATH=/app/miniconda3/bin:$PATH

# working dir
WORKDIR /app

# clone the repo
RUN git clone --depth 1 https://github.com/neherlab/pan-genome-analysis.git

# conda env
RUN conda env create -f /app/pan-genome-analysis/panX-environment.yml && \
    conda clean -a -y && \
    rm -rf /app/miniconda3/pkgs/*

# make panX.py globally accessible
RUN ln -s /app/pan-genome-analysis/panX.py /usr/local/bin/panX.py && \
    chmod +x /usr/local/bin/panX.py

# set entry point
ENTRYPOINT ["bash", "-c", "source activate panX && exec bash"]

# start bash
CMD ["bash"]
