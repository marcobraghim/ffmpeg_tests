#!/bin/zsh

currentDir=${0:a:h}

cd $currentDir

echo `pwd`

# noglob ffmpeg -y -i "viewport_bg.png" -i "main-media.mp4" -i "widgets.png" \
# -filter_complex "[1:v]scale=720:-2[mainMedia];[0:v][mainMedia]overlay=x=0:y='H/2'-'h/2'[mix1];[2:v]scale=720:-2[widgets];[mix1][widgets]overlay[outfile]" \
# -framerate 30 \
# -b:v 1.0k \
# -s 576x1024 \
# -crf 21 \
# -preset medium \
# -map [outfile] output.mp4


noglob ffmpeg -y -i "../viewport_bg.png" -i "main-media.mp4" -i "../widgets.png" \
-filter_complex "[1:v]scale=720:-2[mainMedia];[0:v][mainMedia]overlay=x=0:y='H/2'-'h/2'[mix1];[2:v]scale=720:-2[widgets];[mix1][widgets]overlay[outfile]" \
-framerate 30 \
-b:v 1.0k \
-b:a 160k \
-c:a aac \
-c:v libx264 \
-s 720x1280 \
-crf 21 \
-preset medium \
-map [outfile] \
-map 1:a? output.mp4

noglob ffmpeg -y -i "output.mp4" -filter_complex "[0:v]scale=576:-1, crop=576:802:(iw/2)-(ow/2):(ih/2)-(oh/2)" output-cropped.mp4
