%2021-7-1 luke 信号与系统大作业1_2 选峰定节奏
%这里的代码看起来比较繁琐主要是因为加入了很多修饰画图的操作
clear all;
close all;
clc;

%提取前12s的test.wav音频
n = 1/44100:1/44100:12;
[x,FS] = audioread('test.wav',[1,12*44100],'double');
FS;
x=x(:,1:1);
figure(1);
subplot(3,1,1);
plot(n,x);
set(gca,'Xlim',[0,12],'YLim',[-1,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('x(t)','Fontsize',14);
title('original signal','Fontsize',14);
sound(x,FS);pause(12);

y1 = x.^2;
subplot(3,1,2);
plot(n,y1);
set(gca,'Xlim',[10,12],'YLim',[0,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('y1(t)','Fontsize',14);
title('signal after amplitude squaring','Fontsize',14);
sound(2*y1,FS);pause(12);

%加窗平滑得包络
M = 2000;
w = window(@kaiser,M)/M; %平窗

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

subplot(3,1,2);
plot(n,y2);
set(gca,'Xlim',[10.8,11.6],'YLim',[0,0.3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y2(t)','Fontsize',14);
title('signal after windowing','Fontsize',14);
sound(10.*y2,FS);pause(12);



%差分提取变化点
for i = 1:12*44100
    if i-1>0
        y3(i) = y2(i) - y2(i-1);
    else
        y3(i) = y2(i);
    end
end
figure(2);
subplot(3,1,1);
plot(n,y3);
set(gca,'Xlim',[0,12],'YLim',[-1E-3,1E-3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y3(t)','Fontsize',14);
title('signal after differentiation','Fontsize',14);
sound(1000.*y3,FS);pause(12);

%半波整流取正值
for i = 1:12*44100
    y4(i) = max([y3(i),0]);
end
subplot(3,1,2);
plot(n,y4);
set(gca,'Xlim',[0,12],'YLim',[0,1E-3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y4(t)','Fontsize',14);
title('signal after half wave rectification','Fontsize',14);
sound(1000.*y4,FS);pause(12);

range = 5000;
limit = 9E-5;
for i = 1:1:12*44100
    if y4(i)>limit && y4(i) == max(y4(:,max([i-range,1]):min([i+range,12*44100]))) 
        y(i) = y4(i);
        y_plot(i) = y4(i);
    else
        y_plot(i) = -1;%为了画图时不在x轴显示一堆圆圈做了一个y的副本，只在画图的时候用
        y(i) = 0;%后续处理用这个
    end
end

subplot(3,1,3);
plot(n,y4,n,y_plot,'o','LineWidth',1.4,'MarkerEdgeColor','red','MarkerSize',12);

title(['signal after peak picking'],'Fontsize',14);%显示窗类型
set(gca,'Xlim',[0,12],'YLim',[0,1E-3],'Fontsize',14);
ylabel('y(t)','Fontsize',14);
sound(1000.*y,FS);pause(12);