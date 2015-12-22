#!/bin/bash

ln -s ../profiles/car.lua profile.lua
ln -s ../profiles/lib/
touch .stxxl
touch /tmp/stxxl
echo "disk=/tmp/stxxl,30G,syscall" > .stxxl