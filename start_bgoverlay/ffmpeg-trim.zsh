#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

noglob ffmpeg -y \
-i "purple_bg.png" \
-i "IMG_0026.png" \
-ss 0:00:09.590000 \
-t 0:00:09.911000 \
-i "daniel_duncan.mp4" \
-filter_complex "\
    [0:v]scale=720.0:-2[bg];\
    [1:v]scale=720.0:-2[widgets];\
    [2:v]scale=720.0:-2[mainMedia];\
    [bg][mainMedia]overlay=x=(W-w)/2:y=(H-h)/2[mix1];\
    [mix1][widgets]overlay[outfile]" \
-r 30 \
-b:a 160k \
-c:a aac \
-c:v libx264 \
-s 720x1280 \
-crf 21 \
-preset medium \
-map [outfile] \
-map 2:a?  \
test_output.mp4

