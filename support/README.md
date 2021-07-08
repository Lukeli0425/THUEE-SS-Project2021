# Project-for-Signals-and-Systems-2021
清华大学谷源涛老师《信号与系统》大作业2021

关于大作业内容的具体说明参见[作业说明（初稿）](Project2021.pdf)（**作业说明以网络学堂发布版本为准**）

## Installation
- Clone this repo
- Make sure you have FFmpeg in your computer. Simply run `ffmpeg -version`. 
If FFmpeg is not installed, you can follow the instructions [here](https://ffmpeg.org/download.html). Or if you have [Homebrew](https://brew.sh/) in your MacOS, simply `brew install ffmpeg`.

## Introduction

1. [【脚本1】 ](scripts/merge.sh)    根据文件中指定的顺序直接合并视频
2. [【脚本2】 ](scripts/merge_time.sh)  根据文件中指定的顺序以及各个视频的开始和结束时间合并视频

## Usage

* For MacOS and Linux

    1. [【脚本1】 ](scripts/merge.sh)

        - 修改视频合并顺序。在[input.txt](input/input.txt)中按顺序输入需要合并的视频片段名称。例如，想要按照顺序合并`3.mp4`,`1.mp4`,`8.mp4`，此时input.txt中的内容应该为

            ``` text
            3
            1
            8
            ```

        - 修改视频地址路径。在[merge.sh](scripts/merge.sh)第一行中修改视频以及音频文件夹路径（该路径应该包括所有的视频序列以及`test.wav`背景音乐）。

        - 运行脚本`merge.sh`。

            ```
            bash scripts/merge.sh
            ```
        会生成两个文件，`out/result.mp4`是合并后的视频文件，`out/result_bgm.mp4`是合并以及添加BGM后的视频文件。
        
    2. [【脚本2】 ](scripts/merge_time.sh)

        - 修改视频合并顺序，以及每个视频的开始和结束时间。在[input_time.txt](input/input_time.txt)中按顺序输入需要合并的视频片段名称，以及视频的开始和结束时间，中间用空格隔开，每个视频片段占一行。例如，想要按照顺序合并`3.mp4`,`1.mp4`,`8.mp4`，`1.mp4`对应的开始时间和结束时间为1s-3s。此时input.txt中的内容应该为

            ``` text
            3 1.5:2.5  # 3.mp4的第1.5s至第2.5s放在拼接后视频的第1段
            1 1:3      # 1.mp4的第1s至第3s放在拼接后视频的第2段
            8 0:4      # 8.mp4的第0s至第4s放在拼接后视频的第3段
            ```

        - 修改视频地址路径。在[merge.sh](scripts/merge_time.sh)第一行中修改视频以及音频文件夹路径（该路径应该包括所有的视频序列以及`test.wav`背景音乐）。

        - 运行脚本`merge.sh`。

            ```
            bash scripts/merge_time.sh
            ```
        会生成两个文件，`out/result.mp4`是合并后的视频文件，`out/result_bgm.mp4`是合并以及添加BGM后的视频文件。



* For Windows

    <font color='red'>注意！！！Windows中txt文件默认换行方式为CRLF，请将input.txt的换行方式修改为LF否则会出错</font>

    下载[Git](https://git-scm.com/downloads)

    1. [【脚本1】 ](scripts/merge.sh)

        - 修改视频合并顺序。在[input.txt](input/input.txt)中按顺序输入需要合并的视频片段名称。例如，想要按照顺序合并`3.mp4`,`1.mp4`,`8.mp4`，此时input.txt中的内容应该为

            ``` text
            3
            1
            8
            ```

        - 修改视频地址路径。在[merge.sh](scripts/merge.sh)第一行中修改视频以及音频文件夹路径（该路径应该包括所有的视频序列以及`test.wav`背景音乐）。<font color='red'>注意Windows路径应更改为形如"D:\met/met1"的形式，其中除D:\中的\外,\全部改为/。以及请不要将素材文件放在c盘目录下。</font>

        - 运行脚本`merge.sh`。

            ```
            bash scripts/merge.sh
            ```
        会生成两个文件，`out/result.mp4`是合并后的视频文件，`out/result_bgm.mp4`是合并以及添加BGM后的视频文件。

    2. [【脚本2】 ](scripts/merge_time.sh)

        - 修改视频合并顺序，以及每个视频的开始和结束时间。在[input_time.txt](input/input_time.txt)中按顺序输入需要合并的视频片段名称，以及视频的开始和结束时间，中间用空格隔开，每个视频片段占一行。例如，想要按照顺序合并`3.mp4`,`1.mp4`,`8.mp4`，`1.mp4`对应的开始时间和结束时间为1s-3s。此时input.txt中的内容应该为

            ``` text
            3 1.5:2.5  # 3.mp4的第1.5s至第2.5s放在拼接后视频的第1段
            1 1:3      # 1.mp4的第1s至第3s放在拼接后视频的第2段
            8 0:4      # 8.mp4的第0s至第4s放在拼接后视频的第3段
            ```

        - 修改视频地址路径。在[merge.sh](scripts/merge_time.sh)第一行中修改视频以及音频文件夹路径（该路径应该包括所有的视频序列以及`test.wav`背景音乐）。<font color='red'>注意Windows路径应更改为形如"D:\met/met1"的形式，其中除D:\中的\外,\全部改为/。以及请不要将素材文件放在c盘目录下。</font>

        - 运行脚本`merge.sh`。

            ```
            bash scripts/merge_time.sh
            ```
        会生成两个文件，`out/result.mp4`是合并后的视频文件，`out/result_bgm.mp4`是合并以及添加BGM后的视频文件。

## Acknowledgement
- [FFmpeg](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwi-s5SmupHwAhXIFogKHclNCNAQFjAAegQIBxAD&url=https%3A%2F%2Fwww.ffmpeg.org%2F&usg=AOvVaw09zXstjq6AgcEKkXkTNIzA)
- [How to add a new audio (not mixing) into a video using ffmpeg?](https://stackoverflow.com/questions/11779490/how-to-add-a-new-audio-not-mixing-into-a-video-using-ffmpeg/11783474#11783474)
- [FFmpeg split video and merge back](https://superuser.com/questions/1229945/ffmpeg-split-video-and-merge-back)
- [Buffer Queue Overflow](https://superuser.com/questions/1135095/ffmpeg-buffer-queue-overflow-error-appears-when-adding-audio-with-amix-to-overl)
