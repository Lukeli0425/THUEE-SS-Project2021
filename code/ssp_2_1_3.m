%2021-7-4 luke �ź���ϵͳ����ҵ2_1_3 (���ơ����Ҷȡ�����)����̽���˲��������
%����Ĵ��뿴�����ȽϷ�����Ҫ����Ϊ�����˺ܶ����λ�ͼ�Ĳ���
clear all;
close all;
clc;

%��ȡ��Ƶ
[x,FS] = audioread('test.wav');
Music_Intensity = Get_Intensity(x,FS);
