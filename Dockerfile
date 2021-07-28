# Use Ubuntu image for linux/386
ARG UBUNTU_VER=18.04
FROM i386/ubuntu:${UBUNTU_VER}

# GCC version
ARG GCC_VER=8

# Ceedling version
ARG CEEDLING_VER=0.29.1

# Gcovr version (git tag)
# Pass GCOVR_VER=master for latest gcovr commit
ARG GCOVR_VER=4.1

# Install:
# gcc with libc6-dev (GNU C Library)
# ceedling with ruby
# gcovr with git python-setuptools python-jinja2
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
      software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get -y --no-install-recommends install \
      gcc-${GCC_VER} libc6-dev \
      ruby \
      git python-setuptools python-jinja2 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VER} 0 --slave /usr/bin/gcov gcov /usr/bin/gcov-${GCC_VER} && \
    gem install ceedling -v ${CEEDLING_VER} && \
    cd /tmp && \
    git clone --branch ${GCOVR_VER} --depth 1 https://github.com/gcovr/gcovr.git && \
    cd gcovr && \
    python2 setup.py install && \
    cd /tmp && \
    rm -r * && \
    apt-get -y --auto-remove purge git software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/project

ENTRYPOINT ["ceedling"]
CMD ["help"]

