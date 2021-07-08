# THUEE Signal and Systems Project 2021
## 清华大学电子工程系2021春信号与系统大作业《B站，我来了！》

### 作业内容
这次作业利用Matlab研究了混剪视频的方法，主要着眼于背景音乐和视频片段的激烈度匹配。具体而言，对于给定的一段背景音乐和若干视频片段，我们希望从中选出若干视频片段，按一定顺序与背景音乐拼接称为一段视频，使得生成的视频的冲击力最大。视频的冲击力定义为视频片段的激烈度组成的序列和对应音频片段的激烈度组成的序列的相关系数。一个序列的激烈度则定义为该序列组成的向量的二范数。

（详见Project2021.pdf）

### 文件清单
#### code/
    包含所有代码（.m文件）的文件夹，其中包含了完成全部任务的代码，具体功能如下：
    ssp_1_1_1.m			    固定窗长度，对比不同窗函数的效果
	ssp_1_1_2.m		    	固定窗函数类型，对比不同长度的窗函数的效果
	ssp_1_1_3.m		    	计算得到半波整流波形
	ssp_1_2.m		    	选峰定节奏
	ssp_2_1_1.m		    	探索低通滤波器系数的设计
	Get_Intensity.m	    	求序列的激烈度序列和激烈度的一般方法，封装在函数内
	ssp_2_1_3.m		    	求背景音乐的激烈度序列
	ssp_2_2.m			    对前5个视频片段的激烈度进行排序
	ssp_2_3.m		    	生成最终视频的算法（读入音视频 -> 写入input.txt）


#### result/ 	
    内含最终完成的剪辑视频以及按顺序存放素材文件名的文件
	input.txt  			    遍历5000次得到的按顺序存放素材文件名的文件(对应result_bgm_5000.mp4)
	result_bgm_5.mp4 		遍历5次选出最高冲击力的解得到的视频
	result_bgm_50.mp4 		遍历50次选出最高冲击力的解得到的视频
	result_bgm_500.mp4 		遍历500次选出最高冲击力的解得到的视频
	result_bgm_5000.mp4 	遍历5000次选出最高冲击力的解得到的视频（最佳）


#### support/
 	完成作业过程中借鉴的内容:
	merge.sh				提供的脚本1
	README.md		    	提供的脚本的说明


#### figure/
	报告中设计的波形的原始文件（直接从Matlab导出）