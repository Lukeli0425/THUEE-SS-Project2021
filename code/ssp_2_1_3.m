%2021-7-4 luke 信号与系统大作业2_1_3 (绘制“激烈度”序列)首先探索滤波器的设计
%这里的代码看起来比较繁琐主要是因为加入了很多修饰画图的操作
clear all;
close all;
clc;

%提取音频
[x,FS] = audioread('test.wav');
Music_Intensity = Get_Intensity(x,FS);
