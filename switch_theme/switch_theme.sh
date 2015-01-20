#!/bin/bash

set -e
patch -p0 ../Xresources  < Xresources.patch
patch -p0 ../tmux.conf  < tmux.conf.patch

