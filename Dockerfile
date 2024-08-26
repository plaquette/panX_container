FROM python:3.8-slim

WORKDIR /app

# install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends bash wget git && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /miniconda && \
    rm /tmp/miniconda.sh && \
    /miniconda/bin/conda clean -t -i -p -y && \
    ln -s /miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# clone the repository
RUN git clone --depth 1 https://github.com/neherlab/pan-genome-analysis.git

# create and activate the conda environment
RUN /bin/bash -c "source /miniconda/etc/profile.d/conda.sh && \
    conda env create -f /app/pan-genome-analysis/panX-environment.yml && \
    conda clean -a -y && \
    rm -rf /app/miniconda3/pkgs/*"

# ensure the conda environment is activated in new shell sessions
RUN echo "source /miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate panX" >> ~/.bashrc

# make panX.py globally accessible
RUN ln -s /app/pan-genome-analysis/panX.py /usr/local/bin/panX.py && \
    chmod +x /usr/local/bin/panX.py

# use the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# set PATH to include conda binaries
ENV PATH="/miniconda/bin:/miniconda/condabin:/miniconda/envs/panX/bin:$PATH"

# set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]

