%2021-7-4 luke �ź���ϵͳ����ҵ2_2 �Ƚ�5 ����Ƶ�ġ����Ҷȡ�����
%����Ĵ��뿴�����ȽϷ�����Ҫ����Ϊ�����˺ܶ����λ�ͼ�Ĳ���
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