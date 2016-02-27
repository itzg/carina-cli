#!/bin/sh

if [ -f /secrets ]; then
    source /secrets
fi

/usr/local/bin/carina $@