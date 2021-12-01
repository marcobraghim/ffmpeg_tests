#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

# [1:v]scale=720.0:-2:force_original_aspect_ratio=increase,pad=720.0:1280.0:-1:-1:color=purple[mainMedia];\

noglob ffmpeg -y \
-i "widgets.png" \
-i "media.mov" \
-filter_complex "\
    [1:v]scale=720:-2:force_original_aspect_ratio=decrease,pad=720:1280:-1:-1:color=green[mainMedia];\
    [0:v]scale=720:-2[widgets];\
    [mainMedia][widgets]overlay[outfile]" \
-r 30 \
-b:a 160k \
-c:a aac \
-c:v libx264 \
-s 288x512 \
-crf 21 \
-preset medium \
-map [outfile] \
-map 1:a? output.mp4

