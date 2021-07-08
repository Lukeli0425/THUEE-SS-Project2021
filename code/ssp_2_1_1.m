%2021-7-1 luke �ź���ϵͳ����ҵ2_1_1 (���ơ����Ҷȡ�����)����̽���˲��������
%����Ĵ��뿴�����ȽϷ�����Ҫ����Ϊ�����˺ܶ����λ�ͼ�Ĳ���
clear all;
close all;
clc;

%��ȡǰ12s��test.wav��Ƶ
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
% sound(x,FS);pause(12);

y1 = x.^2;
subplot(3,1,2);
plot(n,y1);
set(gca,'Xlim',[0,12],'YLim',[0,1],'Fontsize',14);
xlabel('Time(sec)','Fontsize',14);
ylabel('y1(t)','Fontsize',14);
title('signal after amplitude squaring','Fontsize',14);
% sound(2*y1,FS);pause(12);

%�Ӵ�ƽ���ð���
M = 1000;
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

subplot(3,1,3);
plot(n,y2);
set(gca,'Xlim',[0,12],'YLim',[0,0.3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y2(t)','Fontsize',14);
title('signal after windowing','Fontsize',14);
% sound(10.*y2,FS);pause(12);


%�����ȡ�仯��
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
% sound(1000.*y3,FS);pause(12);

%�벨����ȡ��ֵ
for i = 1:12*44100
    y4(i) = max([y3(i),0]);
end
subplot(3,1,2);
plot(n,y4);
set(gca,'Xlim',[0,12],'YLim',[0,1E-3]);
xlabel('Time(sec)','Fontsize',14);
ylabel('y4(t)','Fontsize',14);
title('signal after half wave rectification','Fontsize',14);
% sound(1000.*y4,FS);pause(12);


range = 5000;
limit = 9E-5;
for i = 1:1:12*44100
    if y4(i)>limit && y4(i) == max(y4(:,max([i-range,1]):min([i+range,12*44100]))) 
        y(i) = y4(i);
        y_plot(i) = y4(i);
    else
        y_plot(i) = -1;%Ϊ�˻�ͼʱ����x����ʾһ��ԲȦ����һ��y�ĸ�����ֻ�ڻ�ͼ��ʱ����
        y(i) = 0;%�������������
    end
end

subplot(3,1,3);
plot(n,y4,n,y_plot,'o','LineWidth',1.4,'MarkerEdgeColor','red','MarkerSize',12);
title(['signal after peak picking'],'Fontsize',14);%��ʾ������
set(gca,'Xlim',[0,12],'YLim',[0,1E-3],'Fontsize',14);
ylabel('y(t)','Fontsize',14);
% sound(1000.*y,FS);pause(12);

%��Ƶ�ͨ�˲���
N = 120000;

w_type = {@kaiser,@rectwin,@taylorwin};
%17�ִ������ĺ����ޱ�
k=2;figure(3);
for i = 1:3
    h = window(w_type{i},N)/N;
    z = conv(h,y);
    z = z(1:length(y));
    
    subplot(3,1,i);
    plot(n,z);
    set(gca,'Xlim',[0,12],'YLim',[0,5E-8]);
    xlabel('Time(sec)','Fontsize',14);
    ylabel('z(n)','Fontsize',14);
    title(['���Ҷ� using ',func2str(w_type{i})],'Fontsize',14);

end


figure(4);
fy = fft(y);
fz = fft(z);

subplot(3,1,1);
plot(abs(fy));
title('Spectrum of y(n)','Fontsize',14);
set(gca,'XLim',[0,6E5]);

subplot(3,1,2);
plot(abs(fz));
title('Spectrum of z(n)','Fontsize',14);
set(gca,'XLim',[0,6E5]);

subplot(3,1,3);
plot(h);
title('Impulse response of lowpass filter (Taylor window)','Fontsize',14);
ylabel('h(n)','Fontsize',14);
set(gca,'XLim',[0,N],'YLim',[0,2/N]);

