#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

# -ss 0:00:00.500000 \
# -t 0:00:01.100000 \

noglob ffmpeg -y \
-i "purple_bg.png" \
-i "widgets.png" \
-i "mainmedia.mp4" \
-filter_complex "\
    [0:v]null[bg];\
    [2:v]setpts=PTS-STARTPTS-0.5/TB,scale=720.0:-2[mainMedia];\
    [bg][mainMedia]overlay=x=(W-w)/2:y=(H-h)/2[mix1];\
    [1:v]scale=720.0:-2[widgets];\
    [mix1][widgets]overlay[outfile]" \
-map [outfile] \
-map 2:a? \
1636032382386.mp4

# -r 30 \
# -b:a 160k \
# -c:a aac \
# -c:v libx264 \
# -s 288x512 \
# -crf 21 \
# -preset medium \
