# Use Ubuntu image for linux/386
# a65d3401e785fbc3192f0046f68e6487134b70ec9ba79a956fecba9122b39378
# d4e038be71aeb476cf7e458b7bd8709ac47ec5ee93b82dc6fb38444227771575
ARG UBUNTU_TAG=19.04@sha256:a65d3401e785fbc3192f0046f68e6487134b70ec9ba79a956fecba9122b39378
FROM ubuntu:${UBUNTU_TAG}

# Gcovr Git tag
# Pass `--build-arg GCOVR_TAG=master` for latest gcovr commit
ARG GCOVR_TAG=4.1

# Ceedling tag
ARG CEEDLING_TAG=0.29.1

# Install:
# gcc with libc6-dev (GNU C Library)
# ruby
# gcovr
RUN apt-get update && \
    apt-get -y --no-install-recommends install && \
      gcc libc6-dev \
      ruby \
      git python-setuptools && \
    cd /tmp && \
    git clone --branch ${GCOVR_TAG} --depth 1 https://github.com/gcovr/gcovr.git  && \
    cd gcovr && \
    python setup.py install && \
    cd /tmp && \
    rm -r * && \
    apt-get -y --auto-remove purge git && \
    gem install ceedling -v ${CEEDLING_TAG} && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/project

ENTRYPOINT ["ceedling"]
CMD ["help"]
