FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y make wget git fontconfig \
      libglib2.0-0 \
      libxrandr2 \
      libxss1 \
      libxcursor1 \
      libxcomposite1 \
      libasound2 \
      libxi6 \
      libxtst6 \
      libsm6 \
      qt5-default &&\
      apt-get clean

RUN apt-get update && \
    apt-get install -y \
      curl \
      software-properties-common && \
    curl http://apt.isis.rl.ac.uk/2E10C193726B7213.asc | apt-key add - && \
    apt-add-repository -y "deb [arch=amd64] http://apt.isis.rl.ac.uk $(lsb_release -c | cut -f 2)-testing main" && \
    apt-add-repository -y ppa:mantid/mantid && \
    apt-get update && apt-get install -y mantidnightly

