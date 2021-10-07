#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

#
# Video case
#
noglob ffprobe -f lavfi -i "movie=../VID-20210523-WA0007.mp4,blackdetect[out0]" -show_entries tags=lavfi.black_start,lavfi.black_end -of default=nw=1

#noglob ffprobe -f lavfi -i "movie=../black-start.mov,blackdetect[out0]" -show_entries tags=lavfi.black_start,lavfi.black_end -of default=nw=1  