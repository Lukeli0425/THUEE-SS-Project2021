function [Intensity,z] = Get_Intensity(x,FS)
%2021-7-4 luke 信号与系统大作业2_2_2 获得激烈度的函数
%这里的代码看起来比较繁琐主要是因为加入了很多修饰画图的操作

draw_figure = 0;

x=x(:,1:1);
Length = length(x);
Time = Length/FS;%音频时长（sec）
n = 1/FS:1/FS:Time;
% sound(x,FS);pause(Time);

y1 = x.^2;
% sound(2*y1,FS);pause(Time);


%加窗平滑得包络
M = 1000;
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
% sound(10.*y2,FS);pause(Time);


%差分提取变化点
for i = 1:Length
    if i-1>0
        y3(i) = y2(i) - y2(i-1);
    else
        y3(i) = y2(i);
    end
end
% sound(1000.*y3,FS);pause(Time);

%半波整流取正值
for i = 1:Length
    y4(i) = max([y3(i),0]);
end
% sound(1000.*y4,FS);pause(Time);


range = 5000;
limit = 9E-5;
for i = 1:1:Length
    if y4(i)>limit && y4(i) == max(y4(:,max([i-range,1]):min([i+range,Length]))) 
        y(i) = y4(i);
        y_plot(i) = y4(i);
    else
        y_plot(i) = -1;%为了画图时不在x轴显示一堆圆圈做了一个y的副本，只在画图的时候用
        y(i) = 0;%后续处理用这个
    end
end
% sound(1000.*y,FS);pause(Time);


%画图
if(draw_figure == 1)
	figure(1);
    subplot(3,1,1);
    plot(n,x);
    set(gca,'Xlim',[0,Time],'YLim',[-1,1],'Fontsize',14);
    xlabel('Time(sec)','Fontsize',14);
    ylabel('x(t)','Fontsize',14);
    title('original signal','Fontsize',14);

    subplot(3,1,2);
    plot(n,y1);
    set(gca,'Xlim',[0,Time],'YLim',[0,1],'Fontsize',14);
    xlabel('Time(sec)','Fontsize',14);
    ylabel('y1(t)','Fontsize',14);
    title('signal after amplitude squaring','Fontsize',14);
    
    subplot(3,1,3);
    plot(n,y2);
    set(gca,'Xlim',[0,Time],'YLim',[0,0.35]);
    xlabel('Time(sec)','Fontsize',14);
    ylabel('y2(t)','Fontsize',14);
    title('signal after windowing','Fontsize',14);

    figure(2);
    subplot(3,1,1);
    plot(n,y3);
    set(gca,'Xlim',[0,Time],'YLim',[-1E-3,1E-3]);
    xlabel('Time(sec)','Fontsize',14);
    ylabel('y3(t)','Fontsize',14);
    title('signal after differentiation','Fontsize',14);

    subplot(3,1,2);
    plot(n,y4);
    set(gca,'Xlim',[0,Time],'YLim',[0,1E-3]);
    xlabel('Time(sec)','Fontsize',14);
    ylabel('y4(t)','Fontsize',14);
    title('signal after half wave rectification','Fontsize',14);


    subplot(3,1,3);
    plot(n,y4,n,y_plot,'o','LineWidth',1.4,'MarkerEdgeColor','red','MarkerSize',12);
    title(['signal after peak picking'],'Fontsize',14);%显示窗类型
    set(gca,'Xlim',[0,Time],'YLim',[0,1E-3],'Fontsize',14);
    ylabel('y(t)','Fontsize',14);
    
    figure(3);
end


%设计低通滤波器
N = 120000;
w_type = {@rectwin,@kaiser,@taylorwin};
for i = 1:1:3
    h = window(w_type{i},N)/N;
    z = conv(h,y);
    z = z(1:length(y));
    if(draw_figure ==1)
        subplot(3,1,i);
        plot(n,z);
        set(gca,'Xlim',[0,Time],'YLim',[0,1E-7]);
        xlabel('Time(sec)','Fontsize',14);
        ylabel('z(n)','Fontsize',14);
        title(['激烈度 using ',func2str(w_type{i})],'Fontsize',14);
    end
end


% figure(4);
% fy = fft(y);
% fz = fft(z);
% 
% subplot(3,1,1);
% plot(abs(fy));
% title('Spectrum of y(n)','Fontsize',14);
% set(gca,'XLim',[0,6E5]);
% 
% subplot(3,1,2);
% plot(abs(fz));
% title('Spectrum of z(n)','Fontsize',14);
% set(gca,'XLim',[0,6E5]);
% 
% subplot(3,1,3);
% plot(h);
% title('Impulse response of lowpass filter (Taylor window)','Fontsize',14);
% ylabel('h(n)','Fontsize',14);
% set(gca,'XLim',[0,N],'YLim',[0,2/N]);

Intensity = 0;
for i = 1:1:Length
    Intensity = Intensity + z(i).*z(i);
end
    Intensity = sqrt(Intensity);
    
    
end

