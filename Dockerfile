# Use Ubuntu image for linux/386
ARG UBUNTU_VER=18.04
FROM i386/ubuntu:${UBUNTU_VER}

# GCC version
ARG GCC_VER

# Ceedling version
ARG CEEDLING_VER

# Gcovr version
ARG GCOVR_VER

# Install:
# gcc with libc6-dev (GNU C Library)
# ceedling with ruby
# gcovr with python3-pip
RUN apt-get update && \
  if [ -z ${GCC_VER} ]; then \
    apt-get -y --no-install-recommends install gcc libc6-dev; \
  else \
    apt-get -y --no-install-recommends install software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get -y --auto-remove purge software-properties-common && \
    apt-get -y --no-install-recommends install gcc-${GCC_VER} libc6-dev && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VER} 0 --slave /usr/bin/gcov gcov /usr/bin/gcov-${GCC_VER}; \
  fi && \
  apt-get -y --no-install-recommends install ruby && \
  if [ -z ${CEEDLING_VER} ]; then \
    gem install ceedling; \
  else \
    gem install ceedling -v ${CEEDLING_VER}; \
  fi && \
  apt-get -y --no-install-recommends install python3-pip && \
  if [ -z ${GCOVR_VER} ]; then \
    pip3 install gcovr; \
  else \
    pip3 install gcovr==${GCOVR_VER}; \
  fi && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /usr/project

ENTRYPOINT ["ceedling"]
CMD ["help"]

