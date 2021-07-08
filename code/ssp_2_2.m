%2021-7-4 luke 信号与系统大作业2_2 比较5 个视频的“激烈度”排序
%这里的代码看起来比较繁琐主要是因为加入了很多修饰画图的操作
clear all;
close all;
clc;

Video_Intensity = repmat(0,[5,1]);

for i=1:1:5
    [x,FS] = audioread([num2str(i),'.mp4']);
    Video_Intensity(i) = Get_Intensity(x,FS);
end

[B,Index] = sort(Video_Intensity,'descend')
% i=5;
% [z,FS,Video_Time(i),Video_Intensity(i)] = Get_Intensity([num2str(i),'.mp4']);