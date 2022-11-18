FROM continuumio/miniconda3

WORKDIR /code

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Initialize conda in bash config fiiles:
RUN conda init bash

# Activate the environment, and make sure it's activated:
RUN echo "conda activate docker-fastAPI" > ~/.bashrc
RUN echo "Make sure fastapi is installed:"
RUN python -c "import fastapi"

COPY . /code/app
CMD uvicorn app.main:app --host 0.0.0.0 --port 80