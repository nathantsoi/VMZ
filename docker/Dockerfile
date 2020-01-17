FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

ARG USER=docker
ARG UID=1000
ARG PYTHON_VERSION=2.7

ENV DEBIAN_FRONTEND noninteractive

# Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    autoconf \
    automake \
    build-essential \
    cmake \
    make \
    git \
    git-core \
    curl \
    ca-certificates \
    vim \
    libatlas-base-dev \
    gfortran \
    unzip \
    libgoogle-glog-dev \
    libgtest-dev \
    libiomp-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libopenmpi-dev \
    libsnappy-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libgflags-dev \
    libjpeg-dev \
    libpng-dev \
    libass-dev \
    libfreetype6-dev \
    libsdl2-dev \
    libtool \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb1-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    pkg-config \
    texinfo \
    wget \
    zlib1g-dev \    
    yasm \
    libx264-dev \
    python2.7-dev
RUN apt install -y python-pip && \
    rm -rf /var/lib/apt/lists/*

# Setup conda
RUN curl -o ~/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
RUN chmod +x ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH

RUN conda init
RUN conda install -y \
    python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing ninja setuptools cmake cffi typing && \
    conda clean -ya

# Build opencv from source
RUN wget https://github.com/opencv/opencv/archive/3.4.3.zip -O opencv-3.4.3.zip && \
    unzip opencv-3.4.3.zip && \
    cd opencv-3.4.3 && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D PYTHON2_EXECUTABLE=/opt/conda/bin/python \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_SHARED_LIBS=ON .. && \
    make -j12 && \
    make install && \
    ldconfig
RUN ln -s /usr/local/lib/python2.7/site-packages/cv2.so /opt/conda/lib/python2.7/site-packages/cv2.so

# Build nasm
RUN mkdir -p /ffmpeg_sources /bin
RUN cd /ffmpeg_sources && \
    wget https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.bz2 && \
    tar xjvf nasm-2.14.02.tar.bz2 && \
    cd nasm-2.14.02 && \
    ./autogen.sh && \
    PATH="/bin:$PATH" ./configure --prefix="/ffmpeg_build" --bindir="/bin" && \
    make && \
    make install

# Build ffmpeg
RUN cd /ffmpeg_sources && \
    wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
    tar xjvf ffmpeg-snapshot.tar.bz2 && \
    cd ffmpeg && \
    PATH="/bin:$PATH" PKG_CONFIG_PATH="/ffmpeg_build/lib/pkgconfig" ./configure \
    --prefix="/ffmpeg_build" \
    --pkg-config-flags="--static" \
    --extra-cflags="-I/ffmpeg_build/include" \
    --extra-ldflags="-L/ffmpeg_build/lib" \
    --extra-libs="-lpthread -lm" \
    --bindir="/bin" \
    --enable-gpl \
    --enable-libvorbis \
    --enable-libx264 \
    --enable-nonfree && \
    PATH="/bin:$PATH" make -j12 && \
    make install
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
RUN hash -r && \
    ldconfig

# Build pytorch from source
RUN conda install -c pytorch magma-cuda101
RUN pip install lmdb flask future graphviz hypothesis jupyter matplotlib protobuf pydot python-nvd3 pyyaml requests scikit-image scipy six tornado
RUN git clone --recursive https://github.com/pytorch/pytorch && \
    cd pytorch && \
    git submodule update --init --recursive && \
    USE_OPENCV=1 USE_FFMPEG=1 USE_LMDB=1 python setup.py install
ENV PYTHONPATH $PYTHONPATH:/pytorch/build

RUN conda install pandas scikit-learn h5py

RUN adduser --disabled-password --gecos "" --uid ${UID} ${USER}
USER ${USER}
ENV HOME /home/${USER}
WORKDIR /home/${USER}
RUN mkdir /home/${USER}/VMZ /home/${USER}/epic_kitchens
ENV PYTHONPATH /home/${USER}/VMZ:$PYTHONPATH