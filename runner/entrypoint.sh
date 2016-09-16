#!/usr/bin/env bash

cp -r $SRC/* $ROOTFS/
mkdir -p $ROOTFS/app/logs $ROOTFS/run/nginx
touch $ROOTFS/app/logs/error.log
