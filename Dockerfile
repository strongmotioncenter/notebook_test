FROM python:3.9-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt  

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER
 
COPY . ${HOME}
WORKDIR ${HOME}

WORKDIR /home/${NB_USER}

USER ${USER}
