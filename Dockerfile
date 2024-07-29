FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04 

# Set timezone and install tzdata package
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN apt-get update && \
    apt-get install -y tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    pkg-config \
    vim \
    curl \
    tmux \
    software-properties-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add deadsnakes PPA and install Python 3.10
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    python3.10-distutils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install pip for Python 3.10
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

# Set Python 3.10 as the default python3 and pip3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2 && \
    update-alternatives --install /usr/bin/pip3 pip3 /usr/local/bin/pip3.10 1

# Create symbolic links for python and pip
RUN ln -s /usr/bin/python3.10 /usr/bin/python && \
    ln -s /usr/local/bin/pip3.10 /usr/bin/pip

# Install pip packages
RUN pip install gpustat opencv-python && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install additional apt packages
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]




