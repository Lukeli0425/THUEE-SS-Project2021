%2021-7-1 luke 信号与系统大作业1_1_1  固定阶数M=900，改变窗函数类型
%这里的代码看起来比较繁琐主要是因为加入了很多修饰画图的操作
clear all;
close all;
clc;

%提取前12s的test.wav音频
n = 1/44100:1/44100:12;
[x,FS] = audioread('test.wav',[1,12*44100],'double');
x=x(:,1:1);
FS
figure(1);
subplot(4,1,1);
plot(n,x);
set(gca,'Xlim',[0,12],'YLim',[-1,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('x(t)','Fontsize',14);
title('original signal','Fontsize',14);
%sound(x,FS);%播放音频

%幅度平方得能量
y1 = x.^2;
subplot(4,1,2);
plot(n,y1);
set(gca,'Xlim',[0,12],'YLim',[0,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('y1(t)','Fontsize',14);

M = 900;
w_type = {@bartlett,@barthannwin,@blackman,@blackmanharris,@bohmanwin,@chebwin,@flattopwin,@gausswin,@hamming,@hann,@kaiser,@nuttallwin,@parzenwin,@rectwin,@taylorwin,@tukeywin,@triang};
%17种窗函数的函数巨柄

k = 1;
for m = 1:17 %17种窗函数都尝试一下
    w = window(w_type{m},M)/M; %构造窗函数，为了幅度合适除以M
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
    
    if (m==3) || (m==8) || (m==13)
        k=k+1;
        figure(k);%每个figure中画5个波形，因此每画五个新开一个figure
    end
    
    if(m<=2) %前两个波形和y(n) y1(n)画在一起
    	subplot(4,1,m+2);
    else
        subplot(5,1,m+8 - 5*k);
    end
    
    plot(n,y2);
    title(['y2(t) using ',func2str(w_type{m})],'Fontsize',14);%显示窗类型
    set(gca,'Xlim',[0,12],'YLim',[0,0.3],'Fontsize',14);
    ylabel('y2(t)','Fontsize',14);
end