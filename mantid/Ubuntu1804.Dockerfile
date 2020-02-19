FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
      curl \
      software-properties-common && \
    curl http://apt.isis.rl.ac.uk/2E10C193726B7213.asc | apt-key add - && \
    apt-add-repository -y "deb [arch=amd64] http://apt.isis.rl.ac.uk $(lsb_release -c | cut -f 2)-testing main" && \
    apt-add-repository -y ppa:mantid/mantid && \
    apt-get update && apt-get install mantidnightly 

