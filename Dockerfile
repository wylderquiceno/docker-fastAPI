FROM continuumio/miniconda3

WORKDIR /code

SHELL ["/bin/bash", "--login", "-c"]

COPY environment.yml .
RUN conda env create -f environment.yml

RUN conda init bash

RUN echo "conda activate docker-fastAPI" > ~/.bashrc
RUN echo "Make sure fastapi is installed:"
RUN python -c "import fastapi"

COPY . /code/app
CMD uvicorn app.main:app --host 0.0.0.0 --port 80