#!/bin/zsh
currentDir=${0:a:h}
cd $currentDir
echo `pwd`

noglob ffmpeg -y -i "image3.png" 
-vf "
    scale=iw*min(720/iw\,1280/ih):ih*min(720/iw\,1280/ih),
    pad=720:1280:(720-iw)/2:(1280-ih)/2:color=purple
"
output.jpg
