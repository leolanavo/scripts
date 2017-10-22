#!/bin/bash

if [ $(setxkbmap -print | grep symbols | cut -d "+" -f 2) = us ]; then 
    setxkbmap br
else
    setxkbmap us
fi
