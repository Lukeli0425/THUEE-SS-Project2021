%2021-7-4 luke �ź���ϵͳ����ҵ2_3 ���ɻ����Ƶ 
clear all;
close all;
clc;

tic;
%��ȡ��ƵƬ��
[Music,FS] = audioread('test.wav');
[Music_Intensity,z] = Get_Intensity(Music,FS);
Music = Music(:,1:1);
Music_Length = length(Music);
Music_Time = Music_Length/FS;%��Ƶʱ����sec��

%��ȡ��ƵƬ�ε���Ƶ
p = zeros([53,1]);%��Ƶ���Ҷ�
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

%���������Ƶ���У��ҳ����
N = 5000;%�������
Impact = zeros([N,1]); %ÿһ�����������Ƶ�ĳ����
Max_Intensity = 0;%�����ܼ��Ҷ�
tic;
for i = 1:1:N
    disp(['Running loop: ',num2str(i)]);
    Picked_Video_Index = randperm(53);%���������ƵƬ���±꼯������
    Picked_Video_Number = 0;
    Picked_Video_Time = 0;
    Music_partition = zeros([53,1]);%��ƵƬ���з�ʱ���
    while(Picked_Video_Time < Music_Time-2) %ѡȡ������������ƵƬ��
        Picked_Video_Number = Picked_Video_Number + 1;
        Music_partition(Picked_Video_Number) = Picked_Video_Time;%��¼��ƵƬ���з�ʱ���
        Picked_Video_Time = Picked_Video_Time + Video_Time(Picked_Video_Index(Picked_Video_Number));
    end
    Music_partition(Picked_Video_Number+1) = Music_Time;
    
    
    %������ƵƬ��
    q = zeros([Picked_Video_Number,1]);
    for j = 1:1:Picked_Video_Number
        q(j) = norm(z(FS*Music_partition(j)+1:FS*Music_partition(j+1)));
    end

    %�������ϵ��
    p_picked = p(Picked_Video_Index(1:Picked_Video_Number));
    Impact(i) = dot(p_picked,q);
    P_2_norm = norm(p_picked);%��ĸ��p�Ķ�����
    Impact(i) = Impact(i)./P_2_norm;
    
    if(Impact(i) > Max_Intensity)
        Max_Intensity = Impact(i);
        Max_Intensity_Video_Index = Picked_Video_Index(1:Picked_Video_Number);
    end
end
toc;
%��ӡ��Ϣ
disp(['Running loop done! Time used: ',num2str(toc)]);
disp(['Max_Intensity = ',num2str(Max_Intensity)]);
Max_Intensity_Video_Index'

%д���ļ��Ա�ʹ�ýű�������Ƶ
disp('Writing input.txt');
fid=fopen('/Users/Luke/Desktop/Project2021/input/input.txt','wt+');
for j = 1:1:Picked_Video_Number
    fprintf(fid,'%s\n',num2str(Max_Intensity_Video_Index(j)));
end
fclose(fid);

disp('Finish!');
