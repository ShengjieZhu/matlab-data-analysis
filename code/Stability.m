function StabilityFlag = Stability(SourceData,n0,WaveletMethod)
% input: ʱ������
% output: flag 0 ��ƽ�ȣ�1��ƽ��

std_global = std(SourceData);          %std_global ԭʼ���ݵı�׼���ʾȫ�ֲ������

[~,cH]=dwt(SourceData,WaveletMethod);  %����db4С�������źŽ���һά��ɢС���ֽ⡣

std_local = std(cH);             %std_localΪС���任�����Ƶ���ֵı�׼���ʾ�ֲ��������


n = std_global/std_local;

if n>n0      % flag 0 ��ƽ�ȣ�1��ƽ��
    StabilityFlag = 0;
else
    StabilityFlag = 1;
end


end