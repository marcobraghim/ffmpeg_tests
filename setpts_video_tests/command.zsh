#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

noglob ffmpeg -y \
-i "purple_bg.png" \
-i "widgets.png" \
-ss 0:00:00.000000 \
-t 0:00:15.000000 \
-i "mainmedia.mp4" \
-filter_complex "\
    [2:v]scale=720.0:-2[mainMedia];\
    [0:v][mainMedia]overlay=x=(W-w)/2:y=(H-h)/2[mix1];\
    [1:v]scale=720.0:-2[widgets];\
    [mix1][widgets]overlay[outfile]" \
-map [outfile] \
-map 2:a? \
output.mp4

