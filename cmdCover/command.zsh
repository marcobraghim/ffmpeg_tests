#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

# noglob ffmpeg -y \
# -filter_complex "
#     [0:v]scale=720.0:-2:force_original_aspect_ratio=decrease,pad=720.0:1002.5:-1:-1:color=purple[fg];
#     [1:v]scale=720.0:-2[widgets];
#     [fg][widgets]overlay[outfile]" 
# -s 720x1280 
# -frames:v 1 
# -preset veryslow 
# -map [outfile] 


# noglob ffmpeg -y \
# -i "image2.jpg" \
# -i "widgets.png" \
# -filter_complex "\
#     [0:v]scale=720.0:-2:force_original_aspect_ratio=decrease,pad=720.0:1002.5:-1:-1:color=purple[fg];\
#     [1:v]scale=720.0:-2[widgets];\
#     [fg][widgets]overlay[outfile]" \
# -s 288x512 \
# -frames:v 1 \
# -preset veryslow \
# -map [outfile] output.jpg

# =========================================

# noglob ffmpeg -y \
# -i "image2.jpg" \
# -i "widgets.png" \
# -filter_complex "\
#     [0:v]scale=720.0:-2:force_original_aspect_ratio=decrease,pad=720.0:1002.5:-1:-1:color=purple[fg];\
#     [1:v]scale=720.0:-2[widgets];\
#     [fg][widgets]overlay[outfile]" \
# -s 288x401 \
# -frames:v 1 \
# -preset veryslow \
# -map [outfile]  \
# 1635944851423.jpg

# noglob ffmpeg -y \
# -i "image2.jpg" \
# -i "widgets.png" \
# -filter_complex "\
#     [0:v]scale=720.0:-2:force_original_aspect_ratio=decrease,pad=720.0:1002.5:-1:-1:color=purple[fg];\
#     [1:v]scale=720.0:-2[widgets];\
#     [fg][widgets]overlay[outfile]" \
# -s 720x1003 \
# -frames:v 1 \
# -preset veryslow \
# -map [outfile] \
# 1635944890977.jpg

# =======================================

-y -loop 1 -t 3 
-i "af71ba811d58.jpeg" 
-i "1635948658258.png" 
-ignore_loop 0 -i "1635948632148.gif" 
-filter_complex "
    [1:v]scale=720.0:-2[widgets];
    [0:v]scale=720.0:-2:force_original_aspect_ratio=decrease,pad=720.0:1002.5:-1:-1:color=purple,hue=h=0:s=1:b=0[mainMedia];
    [mainMedia][widgets]overlay[mix1];
    [2:v]rotate=-0.19102621923121754:ow=oh:oh=(ih*2):c=none,scale=-2:369.3056405881755[gif1];
    [mix1][gif1]overlay=131.2291739738498:123.83658609540453:shortest=1[outfile]" 
-r 30 
-c:v libx264 
-s 288x401 
-preset veryslow 
-map [outfile]  
1635948658375.mp4



