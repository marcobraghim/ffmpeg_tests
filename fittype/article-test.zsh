#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

#
# Video case
#
noglob ffmpeg -y -i "../viewport_bg.png" -i "../VID-20210523-WA0007.mp4" -i "../widgets.png" \
-filter_complex "\
[1:v]scale=-2:1280[mainMedia];\
[0:v][mainMedia]overlay=x=(W-w)/2:y=\'H/2\'-\'h/2\'[mix1];\
[2:v]scale=720:-2[widgets];\
[mix1][widgets]overlay[outfile]" \
-framerate 30 \
-b:v 1.0k \
-b:a 160k \
-c:a aac \
-c:v libx264 \
-s 720x1280 \
-crf 21 \
-preset veryfast \
-map [outfile] \
-map 1:a? output.jpg

#
# Image case
#
# noglob ffmpeg -y -i "../viewport_bg.png" -i "../1622566559740.jpg" -i "../widgets.png" \
# -filter_complex "\
# [1:v]transpose=3,hflip,scale=-2:1280[mainMedia];\
# [0:v][mainMedia]overlay=x=(W-w)/2:y=\'H/2\'-\'h/2\'[mix1];\
# [2:v]scale=720:-2[widgets];\
# [mix1][widgets]overlay[outfile]" \
# -preset veryfast \
# -map [outfile] \
# -map 1:a? output.jpg

