FROM debian:11.6-slim
ENV INSTALL_PATH /signal-server
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

RUN apt-get update && apt-get install -y \
  cmake \
  g++ \
  imagemagick \
  libbz2-dev \
  libz-dev \
  python2 \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p $INSTALL_PATH/utils
WORKDIR $INSTALL_PATH/utils
ADD utils .
RUN cd sdf/usgs2sdf && cmake .
RUN cd sdf/usgs2sdf && make

RUN mkdir -p $INSTALL_PATH/src
WORKDIR $INSTALL_PATH/src
ADD src .
RUN cmake .
RUN make

ENTRYPOINT ["./signalserver"]
