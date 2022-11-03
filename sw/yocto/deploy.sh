#!/bin/bash

bitbake package-index
rclone sync tmp/deploy/rpm fein:packages/yocto/rpm/aarch64

