#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

# noglob ffmpeg -y \
# -i "purple_bg.png" \
# -i "widgets.png" \
# -ss 0:00:00.000000 \
# -t 0:00:15.000000 \
# -i "mainmedia.mp4" \
# -filter_complex "\
#     [2:v]scale=720.0:-2[mainMedia];\
#     [0:v][mainMedia]overlay=x=(W-w)/2:y=(H-h)/2[mix1];\
#     [1:v]scale=720.0:-2[widgets];\
#     [mix1][widgets]overlay[outfile]" \
# -map [outfile] \
# -map 2:a? \
# output.mp4

noglob ffmpeg -y \
-i "purple_bg.png" \
-i "widgets.png" \
-ss 0:00:00.000000 \
-t 0:00:15.000000 \
-i "mainmedia.mp4" \
-filter_complex "\
    [2:v]setpts=PTS-STARTPTS,scale=720.0:-2[mainMedia];\
    [0:v][mainMedia]overlay=x=(W-w)/2:y=(H-h)/2[mix1];\
    [1:v]setpts=PTS-STARTPTS,scale=720.0:-2[widgets];\
    [mix1][widgets]overlay[outfile]" \
-map [outfile] \
-map 2:a? \
output.mp4

# The command below will generate the background without file,
# plus with that effect of noise image like old TV's
# 
# 0 => widgets
# 1 => media
# noglob ffmpeg -y \
# -i "widgets.png" \
# -ss 0:00:00.000000 \
# -t 0:00:15.000000 \
# -i "mainmedia.mp4" \
# -filter_complex "\
#     nullsrc=size=720x1280,geq=random(1)*255:128:128[bg];\
#     [1:v]setpts=PTS-STARTPTS,scale=720.0:-2[mainMedia];\
#     [bg][mainMedia]overlay=shortest=1:x=(W-w)/2:y=(H-h)/2[mix1];\
#     [0:v]setpts=PTS-STARTPTS,scale=720.0:-2[widgets];\
#     [mix1][widgets]overlay[outfile]" \
# -map [outfile] \
# -map 1:a? \
# output.mp4