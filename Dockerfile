From ubuntu

MAINTAINER Tiras Zemicael <Tiras.Zemicael@gmail.com>

WORKDIR /tmp


RUN apt-get update && apt-get install -y \
    ca-certificates \
    apt-transport-https \
    apt-utils \
    gnupg \
    openjdk-8-jdk \
    flex \
    bison \
    git \
    make \
    g++ \
    autoconf \
    automake

############### clone verilator, compile and install
RUN git clone http://git.veripool.org/git/verilator
RUN cd /tmp/verilator/ && autoconf && ./configure && make && make install

############### install sbt 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN echo "deb https://dl.bintray.com/sbt/debian /" >> /etc/apt/sources.list.d/sbt.list
RUN apt-get update && apt-get install -y sbt

RUN rm -rf /tmp/*

RUN mkdir /app
WORKDIR /app
VOLUME [ "/app" ]


ENTRYPOINT [ "sbt" ]