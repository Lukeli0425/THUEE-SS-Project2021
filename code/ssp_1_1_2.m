%2021-7-1 luke 信号与系统大作业1_1_2  选定kaiser窗，改变FIR滤波器阶数M
%这里的代码看起来比较繁琐主要是因为加入了很多修饰画图的操作
clear all;
close all;
clc;

%提取前12s的test.wav音频
n = 1/44100:1/44100:12;
[x,FS] = audioread('test.wav',[1,12*44100],'double');
x=x(:,1:1);
FS;
figure(1);
% subplot(4,1,1);
% plot(n,x);
% set(gca,'Xlim',[0,12],'YLim',[-1,1],'Fontsize',14);
% xlabel('Time(sec)','Fontsize',14);
% ylabel('x(t)','Fontsize',14);
% title('original signal','Fontsize',14);
% sound(x,FS); %播放音频

y1 = x.^2;%幅度平方得能量
subplot(4,1,1);
plot(n,y1,'yellow');
set(gca,'Xlim',[0,12],'YLim',[0,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('y1(t)','Fontsize',14);
title('signal after amplitude squaring');

w_type = @kaiser;
M = [100,200,400,800,900,1000,1100,1200,1500,2000,3000];

%改变阶数M画y2
for k = 1:1:11 
    w = window(w_type,M(k))/M(k); %构造窗函数，为了幅度合适除以M
%     for i = 1:12*44100
%         y2(i) = 0;
%         for j = 0:M-1
%             if (i-j+M/2>0)&(i-j+M/2<=12*44100)
%                 y2(i) = y2(i) + w(j+1)*y1(i-j+M/2);%卷积
%             end
%         end
%     end
    y2 = conv(y1,w);%这样写比用循环块
    y2 = y2(1:length(y1));
    
    if(k==4)
        figure(2);
    elseif(k==8)
        figure(3);
    end
 
    if(k<=3)
        subplot(4,1,k+1);
    elseif(k<=7)
        subplot(4,1,k-3)
    else
        subplot(4,1,k-7);
    end
    
    plot(n,y2,'blue');
    title(['FIR M=',num2str(M(k))],'Fontsize',14);%显示窗类型
    set(gca,'Xlim',[0,12],'YLim',[0,0.3],'Fontsize',14);
    ylabel('y2(t)','Fontsize',14);
end