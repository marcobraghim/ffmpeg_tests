#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

# 0 bg
# 1 media
# 2 widgets

# noglob ffmpeg -y \
# -i "image2.jpeg" \
# -i "widgets.png" \
# -filter_complex "\
#     [0:v]crop=720.0:1280.0:iw/2:ih/2[fg];\
#     [1:v]scale=720.0:-2[widgets];\
#     [fg][widgets]overlay[outfile]\
# " \
# -s 288x512 \
# -frames:v 1 \
# -preset veryslow \
# -map [outfile] \
# output.jpg

noglob ffmpeg -y \
-i "af71ba811d58.jpg" \
-i "widgets.png" \
-filter_complex "\
    [0:v]scale=-2:1280:force_original_aspect_ratio=increase,crop=720:1280[fg];\
    [1:v]scale=720.0:-2[widgets];\
    [fg][widgets]overlay[outfile]" \
-s 288x512 \
-frames:v 1 \
-preset veryslow \
-map [outfile] \
output-1.jpg

