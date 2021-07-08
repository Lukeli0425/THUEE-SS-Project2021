%2021-7-4 luke 信号与系统大作业2_3 生成混剪视频 
clear all;
close all;
clc;

tic;
%读取音频片段
[Music,FS] = audioread('test.wav');
[Music_Intensity,z] = Get_Intensity(Music,FS);
Music = Music(:,1:1);
Music_Length = length(Music);
Music_Time = Music_Length/FS;%音频时长（sec）

%读取视频片段的音频
p = zeros([53,1]);%视频激烈度
Video_Time = zeros([53,1]);
Video_Length = zeros([53,1]);
Total_Video_Time = 0;
for i=1:1:53
    [x,FS] = audioread([num2str(i),'.mp4']);
    x = x(:,1:1);
    Video_Length(i) = length(x);
    Video_Time(i) = Video_Length(i)/FS;
    p(i) = Get_Intensity(x,FS);
    Total_Video_Time = Total_Video_Time + Video_Time(i);
end
toc;
disp(['Reading music and clips finished! Time used:',num2str(toc)]);

%随机生成视频序列，找出最佳
N = 5000;%随机次数
Impact = zeros([N,1]); %每一次随机生成视频的冲击力
Max_Intensity = 0;%最大的总激烈度
tic;
for i = 1:1:N
    disp(['Running loop: ',num2str(i)]);
    Picked_Video_Index = randperm(53);%随机生成视频片段下标集合序列
    Picked_Video_Number = 0;
    Picked_Video_Time = 0;
    Music_partition = zeros([53,1]);%音频片段切分时间点
    while(Picked_Video_Time < Music_Time-2) %选取合适数量的视频片段
        Picked_Video_Number = Picked_Video_Number + 1;
        Music_partition(Picked_Video_Number) = Picked_Video_Time;%记录音频片段切分时间点
        Picked_Video_Time = Picked_Video_Time + Video_Time(Picked_Video_Index(Picked_Video_Number));
    end
    Music_partition(Picked_Video_Number+1) = Music_Time;
    
    
    %生成音频片段
    q = zeros([Picked_Video_Number,1]);
    for j = 1:1:Picked_Video_Number
        q(j) = norm(z(FS*Music_partition(j)+1:FS*Music_partition(j+1)));
    end

    %计算相关系数
    p_picked = p(Picked_Video_Index(1:Picked_Video_Number));
    Impact(i) = dot(p_picked,q);
    P_2_norm = norm(p_picked);%分母中p的二范数
    Impact(i) = Impact(i)./P_2_norm;
    
    if(Impact(i) > Max_Intensity)
        Max_Intensity = Impact(i);
        Max_Intensity_Video_Index = Picked_Video_Index(1:Picked_Video_Number);
    end
end
toc;
%打印信息
disp(['Running loop done! Time used: ',num2str(toc)]);
disp(['Max_Intensity = ',num2str(Max_Intensity)]);
Max_Intensity_Video_Index'

%写入文件以便使用脚本生成视频
disp('Writing input.txt');
fid=fopen('/Users/Luke/Desktop/Project2021/input/input.txt','wt+');
for j = 1:1:Picked_Video_Number
    fprintf(fid,'%s\n',num2str(Max_Intensity_Video_Index(j)));
end
fclose(fid);

disp('Finish!');
