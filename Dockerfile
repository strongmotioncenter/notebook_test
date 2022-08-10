FROM FROM jupyter/scipy-notebook:cf6258237ff9
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN git clone https://github.com/usgs/groundmotion-processing.git && \
    cd groundmotion-processing && \
    sed  -i '/libraries.append("omp")/d' setup.py && \
    pip install --no-cache-dir --no-deps . && \
    cd && \
    rm -rf /tmp/*
# Import matplotlib the first time to build the font cache.
RUN MPLBACKEND=Agg python3 -c "import matplotlib.pyplot"

RUN gmrecords -v

RUN mkdir -p /working/data
WORKDIR /working

# Copy the cloudburst framework and helper script
COPY cloudburst/scripts /opt/cloudburst
COPY gmrecords_helper.sh /working

ENTRYPOINT python3 /opt/cloudburst/fw_entrypoint.py    

COPY . ${HOME}
WORKDIR ${HOME}
USER ${USER}
