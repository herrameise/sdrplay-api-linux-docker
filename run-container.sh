#!/bin/bash

docker run \
	-it \
	--user tester \
	--hostname SDRPLAY-TEST \
	--privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v /dev/shm:/dev/shm \
	sdrplay \
	/bin/bash
