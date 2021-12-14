#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

rm -rf output.mp4

# https://superuser.com/questions/1476337/ffmpeg-is-there-a-workaround-for-the-drawtext-fontcolor-alpha-not-working-with
# https://video.stackexchange.com/questions/25693/add-overlay-video-and-animated-text-textbox-and-shadow-with-ffmpeg
# https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
# https://superuser.com/questions/939357/how-to-position-drawtext-text

# No end
noglob ffmpeg \
-y \
-i "article.mp4" -loop 1 \
-i "watermark.png" \
-filter_complex "\
    [0]\
        setpts=PTS-STARTPTS,scale=720:-2,\
        drawtext=fontfile='OpenSans-Regular.ttf':\
        text='@ marcolin':\
        fontcolor=white:fontsize=18:\
        box=1:boxcolor=yellow@0.0:\
        shadowcolor=black@0.6:shadowx=0:shadowy=2:\
        boxborderw=0:x=(10):y=((h-text_h)/2)+58,fade=t=out:st=4.0:d=0.2:alpha=1[mtxt];\
    [0]\
        setpts=PTS-STARTPTS,scale=720:-2,\
        drawtext=fontfile='OpenSans-Regular.ttf':\
        text='@ marcolin':\
        fontcolor=white:fontsize=18:\
        box=1:boxcolor=yellow@0.0:\
        shadowcolor=black@0.6:shadowx=0:shadowy=2:\
        boxborderw=0:x=(w-text_w-16):y=(h-text_h-100),fade=t=in:st=4.0:d=0.1:alpha=1[btxt];\
    [0]setpts=PTS-STARTPTS,scale=720:-2[mainMedia];\
    [mainMedia][mtxt]overlay[middle];\
    [middle][btxt]overlay[res_txt];\
    [1]fade=t=out:st=3.9:d=0.2:alpha=1[wtmk1];\
    [1]fade=t=in:st=4.0:d=0.1:alpha=1[wtmk2];\
    [res_txt][wtmk1]overlay=x=6:y=(H-h+2)/2:shortest=1[res_logo1];\
    [res_logo1][wtmk2]overlay=x=(W-w-10):y=(H-h-114):shortest=1[output]\
" -map [output] 1639484534149.mp4

