FROM nvidia/cuda:11.3.0-base-ubuntu20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  tzdata build-essential libgl1-mesa-glx libglib2.0-0 libgeos-dev python3-openslide \
  curl wget sudo vim htop ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Create a non-root user and switch to it
ARG USER_NAME="pchen6"
RUN adduser --disabled-password --gecos '' --shell /bin/bash ${USER_NAME}
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER_NAME}
USER ${USER_NAME}
ENV HOME=/home/${USER_NAME}
RUN chmod 777 /home/${USER_NAME}
WORKDIR /home/${USER_NAME}

# Install Miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh \
 && bash ~/Miniconda3-py39_4.10.3-Linux-x86_64.sh -p ~/miniconda -b \
 && rm ~/Miniconda3-py39_4.10.3-Linux-x86_64.sh
ENV PATH=/home/${USER_NAME}/miniconda/bin:$PATH

## Create a Python 3.8.5 environment
RUN /home/${USER_NAME}/miniconda/bin/conda install conda-build \
 && /home/${USER_NAME}/miniconda/bin/conda create -y --name py385 python=3.8.5 \
 && /home/${USER_NAME}/miniconda/bin/conda clean -ya
ENV CONDA_DEFAULT_ENV=py385
ENV CONDA_PREFIX=/home/${USER_NAME}/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH

# Python commonly used packages installation
## Using pip
RUN pip install gpustat==0.6.0 setuptools==45
RUN pip openslide-python==1.1.1 Pillow==8.4.0 deepdish==0.3.6
RUN pip numpy==1.19.2 scipy==1.6.0 matplotlib==3.3.2 statsmodels==0.13.0 pandas==1.1.5
RUN pip install opencv-python==4.5.1.48 scikit-image==0.18.3 scikit-learn==1.0.1 xgboost==1.0.0

## Using conda
RUN conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch

# Setting environment variables
ENV HDF5_USE_FILE_LOCKING=FALSE
