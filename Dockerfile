#Docker https://github.com/binder-examples/minimal-dockerfile/blob/master/Dockerfile
FROM python:3.9-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab


# Multistage build from: https://pythonspeed.com/articles/conda-docker-image-size/
FROM arkottke/gmrecords

# copy over files from binder repository into $HOME
COPY . ${HOME}

# set working directory to $HOME
WORKDIR ${HOME}

