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
  && rm -rf /var/lib/apt/lists/*

ADD src .
RUN cmake .
RUN make
ENTRYPOINT ["./signalserver"]
