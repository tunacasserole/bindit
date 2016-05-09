#!/bin/sh

printf "\n---starting xvfb\n"

Xvfb :99 -screen 0 640x480x8 -nolisten tcp &

printf "\n---starting firefox\n"

firefox
