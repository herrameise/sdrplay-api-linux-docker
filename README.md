# SDRplay Linux API

This repository contains the same SDRplay Linux drivers/API available on the [SDRplay website](https://www.sdrplay.com/api/). The packaged script from the website (`SDRplay_RSP_API-Linux-XXX.run`) has several features that make it undesirable for installing and running inside a Docker container with a minimal Linux system and no user interaction. The original installer was run with the `--noexec` and `--keep` flags to obtain the files in this repository. Only the `install_lib.sh` script was altered to produce `install_lib_DOCKER.sh`.

## Installation on the Host

Run the **normal** installation script (NOT `install_libs_DOCKER.sh`):

```bash
$ ./install_libs.sh
```

## Installation in a Docker Container

See the [Dockerfile](Dockerfile) and [run-container.sh](run-container.sh) script for examples of how to incorporate this into a Docker build. The SDRplay API service **needs to be started on the host** before running the container. The directories `/dev/bus/usb` and `/dev/shm` are volume-mounted into the container.

If something like [SoapySDR](https://github.com/pothosware/SoapySDR/wiki) is installed in the container, you can scan for an attached SDR to verify that the API service is functioning as expected:

```
tester@SDRPLAY-TEST:~$ SoapySDRUtil --find="driver=sdrplay"
######################################################
##     Soapy SDR -- the SDR abstraction library     ##
######################################################

Found device 0
  driver = sdrplay
  label = SDRplay Dev0 RSPduo 2301024734 - Single Tuner
  mode = ST
  serial = 2301024734

[...]
```
