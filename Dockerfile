FROM python:3.9-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . ${HOME}
WORKDIR ${HOME}
USER ${USER}
