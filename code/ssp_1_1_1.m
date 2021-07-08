%2021-7-1 luke �ź���ϵͳ����ҵ1_1_1  �̶�����M=900���ı䴰��������
%����Ĵ��뿴�����ȽϷ�����Ҫ����Ϊ�����˺ܶ����λ�ͼ�Ĳ���
clear all;
close all;
clc;

%��ȡǰ12s��test.wav��Ƶ
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
%sound(x,FS);%������Ƶ

%����ƽ��������
y1 = x.^2;
subplot(4,1,2);
plot(n,y1);
set(gca,'Xlim',[0,12],'YLim',[0,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('y1(t)','Fontsize',14);

M = 900;
w_type = {@bartlett,@barthannwin,@blackman,@blackmanharris,@bohmanwin,@chebwin,@flattopwin,@gausswin,@hamming,@hann,@kaiser,@nuttallwin,@parzenwin,@rectwin,@taylorwin,@tukeywin,@triang};
%17�ִ������ĺ����ޱ�

k = 1;
for m = 1:17 %17�ִ�����������һ��
    w = window(w_type{m},M)/M; %���촰������Ϊ�˷��Ⱥ��ʳ���M
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
    
    if (m==3) || (m==8) || (m==13)
        k=k+1;
        figure(k);%ÿ��figure�л�5�����Σ����ÿ������¿�һ��figure
    end
    
    if(m<=2) %ǰ�������κ�y(n) y1(n)����һ��
    	subplot(4,1,m+2);
    else
        subplot(5,1,m+8 - 5*k);
    end
    
    plot(n,y2);
    title(['y2(t) using ',func2str(w_type{m})],'Fontsize',14);%��ʾ������
    set(gca,'Xlim',[0,12],'YLim',[0,0.3],'Fontsize',14);
    ylabel('y2(t)','Fontsize',14);
end