%2021-7-1 luke �ź���ϵͳ����ҵ1_1_3 ����õ��벨��������
%����Ĵ��뿴�����ȽϷ�����Ҫ����Ϊ�����˺ܶ����λ�ͼ�Ĳ���
clear all;
close all;
clc;

%��ȡǰ12s��test.wav��Ƶ
n = 1/44100:1/44100:12;
[x,FS] = audioread('test.wav',[1,12*44100],'double');
FS;
x=x(:,1:1);
 sound(x,FS);pause(12);
figure(1);
subplot(3,1,1);
plot(n,x);
set(gca,'Xlim',[0,12],'YLim',[-1,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('x(t)','Fontsize',14);
title('original signal','Fontsize',14);

y1 = x.^2;
subplot(3,1,2);
plot(n,y1);
set(gca,'Xlim',[0,12],'YLim',[0,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('y1(t)','Fontsize',14);
title('signal after amplitude squaring','Fontsize',14);
 sound(y1,FS);pause(12);

%�Ӵ�ƽ���ð���
M = 1000;
%w = repmat(1/M,[1,M]); %ƽ��
w = window(@kaiser,M)/M; %ƽ��

%     for i = 1:12*44100
%         y2(i) = 0;
%         for j = 0:M-1
%             if (i-j+M/2>0)&(i-j+M/2<=12*44100)
%                 y2(i) = y2(i) + w(j+1)*y1(i-j+M/2);%���
%             end
%         end
%     end
y2 = conv(y1,w);%����д����ѭ����
y2 = y2(1:length(y1)); 
figure(2);
subplot(3,1,1);
plot(n,y2);
set(gca,'Xlim',[0,12],'YLim',[0,0.3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y2(t)','Fontsize',14);
title('signal after windowing','Fontsize',14);
 sound(10.*y2,FS);pause(12);

%�����ȡ�仯��
for i = 1:12*44100
    if i-1>0
        y3(i) = y2(i) - y2(i-1);
    else
        y3(i) = y2(i);
    end
end

subplot(3,1,2);
plot(n,y3);
set(gca,'Xlim',[0,12],'YLim',[-1E-3,1E-3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y3(t)','Fontsize',14);
title('signal after differentiation','Fontsize',14);
 sound(1000.*y3,FS);pause(12);

%�벨����ȡ��ֵ
for i = 1:12*44100
    y4(i) = max([y3(i),0]);
end
subplot(3,1,3);
plot(n,y4);
set(gca,'Xlim',[0,12],'YLim',[0,1E-3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y4(t)','Fontsize',14);
title('signal after half wave rectification','Fontsize',14);
 sound(1000.*y4,FS);pause(12);



