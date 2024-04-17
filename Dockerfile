FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    sudo build-essential cmake file git init libsoapysdr-dev soapysdr-tools usbutils udev

RUN \
    useradd -rm -d /home/tester -s /bin/bash -g 100 -G sudo -u 1000 tester && \
    groupadd -g 1000 tester && \
    echo "tester ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/dont-prompt-tester-for-sudo-password"

USER tester
RUN mkdir -p /home/tester/foss

RUN \
    cd /home/tester/foss && \
    git clone https://github.com/herrameise/sdrplay-api-linux-docker && \
    cd /home/tester/foss/sdrplay-api-linux-docker && ./install_lib_DOCKER.sh
    

RUN \
    cd /home/tester/foss && \
    git clone https://github.com/pothosware/SoapySDRPlay.git && \
    mkdir /home/tester/foss/SoapySDRPlay/build && \
    cd /home/tester/foss/SoapySDRPlay/build && \
    cmake .. && make -j$(nproc) && sudo make install && sudo ldconfig

WORKDIR /home/tester
