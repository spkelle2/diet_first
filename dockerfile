FROM ubuntu:latest

# add wget
RUN apt update && apt install wget git -y

# set environment variables in build and run for conda
ENV PATH="/opt/miniconda3/bin:${PATH}"
ARG PATH="/opt/miniconda3/bin:${PATH}"

# set up miniconda
RUN mkdir -p /opt/miniconda3 &&  \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O /opt/miniconda3/miniconda.sh && \
    bash /opt/miniconda3/miniconda.sh -b -u -p /opt/miniconda3 && \
    rm -rf /opt/miniconda3/miniconda.sh

# set up diet app
RUN cd opt/ && \
    git clone https://github.com/spkelle2/diet.git && \
    cd diet && \
    git checkout dev && \
    conda env create -f environment.yml
ENV FLASK_APP=/opt/diet/app/app.py

# run diet app
ENTRYPOINT . /opt/miniconda3/bin/activate && conda activate diet && python -m flask run --host=0.0.0.0
