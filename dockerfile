FROM ubuntu:latest

# add wget
RUN apt update && apt install wget git -y

# set up miniconda
ENV PATH="/opt/miniconda3/bin:${PATH}"
ARG PATH="/opt/miniconda3/bin:${PATH}"
RUN mkdir -p /opt/miniconda3 &&  \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O /opt/miniconda3/miniconda.sh && \
    bash /opt/miniconda3/miniconda.sh -b -u -p /opt/miniconda3 && \
    rm -rf /opt/miniconda3/miniconda.sh

# set up diet app (todo: update version with each release)
ENV FLASK_APP=/opt/diet/app/app.py
RUN cd opt/ && \
    git clone https://github.com/spkelle2/diet.git && \
    cd diet && \
    git checkout dev && \
    conda env create -f environment.yml && \
    pip install -e .

# run diet app with gunicorn as the server
ENTRYPOINT . /opt/miniconda3/bin/activate && \
    conda activate diet && \
    cd /opt/diet/app/ && \
    gunicorn -w 4 -b 0.0.0.0:8000 app:app
