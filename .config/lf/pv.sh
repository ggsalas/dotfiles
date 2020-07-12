#!/bin/sh

case "$1" in
    *.png|*.jpg|*.jpeg|*.mkv|*.mp4) mediainfo "$1";;
    *) highlight -O ansi "$1" || cat "$1";;
esac
