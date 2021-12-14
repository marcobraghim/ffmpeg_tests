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
-i "IMG_1976.mp4" -loop 1 \
-i "watermark.png" \
-filter_complex "\
    [0]\
        setpts=PTS-STARTPTS,scale=720:-2,\
        drawtext=fontfile=OpenSans-Regular.ttf:\
        text='@ marco':\
        fontcolor=white:fontsize=18:\
        box=1:boxcolor=yellow@0.0:\
        shadowcolor=black@0.6:shadowx=0:shadowy=2:\
        boxborderw=0:x=(10):y=((h-text_h)/2)+47,fade=t=out:st=2.5:d=0.2:alpha=1\
        [middle_txt];\
    [0]\
        setpts=PTS-STARTPTS,scale=720:-2,\
        drawtext=fontfile=OpenSans-Regular.ttf:\
        text='@ marco':\
        fontcolor=white:fontsize=18:\
        box=1:boxcolor=yellow@0.0:\
        shadowcolor=black@0.6:shadowx=0:shadowy=2:\
        boxborderw=0:x=(w-text_w-16):y=(h-text_h-12),fade=t=in:st=2.5:d=0.1:alpha=1\
        [bottom_txt];\
    [0]setpts=PTS-STARTPTS,scale=720:-2[mainMedia];\
    [mainMedia][middle_txt]overlay[middle]; \
    [middle][bottom_txt]overlay[res_txt];\
    [1]fade=t=out:st=2.4:d=0.2:alpha=1[wtmk1];\
    [1]fade=t=in:st=2.5:d=0.1:alpha=1[wtmk2];\
    [res_txt][wtmk1]overlay=x=6:y=(H-h+2)/2:shortest=1[res_logo1];\
    [res_logo1][wtmk2]overlay=x=(W-w-10):y=(H-h-24):shortest=1\
    " \
output_no_end.mp4

# With end video
# noglob ffmpeg \
# -y \
# -i "IMG_1818.mov" -loop 1 \
# -i "watermark.png" \
# -i "end.mp4" \
# -filter_complex "\
#     [0]\
#         setpts=PTS-STARTPTS,scale=720:-2,\
#         drawtext=fontfile=OpenSans-Regular.ttf:\
#         text='@ marco':\
#         fontcolor=white:fontsize=24:\
#         box=1:boxcolor=yellow@0.0:\
#         shadowcolor=black@0.5:shadowx=1:shadowy=1:\
#         boxborderw=5:x=(50):y=(h-text_h)/2,fade=t=out:st=2.5:d=0.2:alpha=1\
#         [middle_txt];\
#     [0]\
#         setpts=PTS-STARTPTS,scale=720:-2,\
#         drawtext=fontfile=OpenSans-Regular.ttf:\
#         text='@ marco':\
#         fontcolor=white:fontsize=24:\
#         box=1:boxcolor=yellow@0.0:\
#         shadowcolor=black@0.5:shadowx=1:shadowy=1:\
#         boxborderw=5:x=(w-text_w-50):y=(h-text_h-100),fade=t=in:st=2.5:d=0.1:alpha=1\
#         [bottom_txt];\
#     [2]\
#         drawtext=fontfile=OpenSans-Regular.ttf:\
#         text='@ marco':\
#         fontcolor=white:fontsize=24:\
#         box=1:boxcolor=white@0.0:\
#         shadowcolor=black@0.5:shadowx=1:shadowy=1:\
#         boxborderw=5:x=(w-text_w)/2:y=((h-h/4)-text_h/2)\
#         [end_bottom_txt];\
#     [0]setpts=PTS-STARTPTS,scale=720:-2[mainMedia];\
#     [mainMedia][middle_txt]overlay[middle]; \
#     [middle][bottom_txt]overlay[res_txt];\
#     [1]fade=t=out:st=2.5:d=0.2:alpha=1[wtmk1];\
#     [1]fade=t=in:st=2.5:d=0.1:alpha=1[wtmk2];\
#     [res_txt][wtmk1]overlay=x=45:y=(H/2-110):shortest=1[res_logo1];\
#     [res_logo1][wtmk2]overlay=x=(W-w-45):y=(H-h-130):shortest=1[result];\
#     [2][end_bottom_txt]overlay[end];\
#     [result][end]concat=v=1:a=0[outv];\
#     [0:a][2:a]concat=v=0:a=1[outa]\
#     " \
# -map '[outv]' -map '[outa]' output_mov.mp4

