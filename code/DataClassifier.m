function DataClass = DataClassifier(SourceData,n0,WaveletMethod,SubFig2)
% input: ʱ������
% output: �������
% �б����(������)-�мල����

%% �ж��Ƿ�ƽ��
ClassFlag = Stability(SourceData,n0,WaveletMethod);   %�ж��Ƿ�ƽ��

%% 
if ClassFlag == 1
    DataClass = 1;                          
else
    ClassFlag = Periodicity(SourceData,SubFig2);               %�ж��Ƿ�����
    if ClassFlag == 1
         DataClass = 2; 
    else
        DataClass = 3; 
    end                                      %DataClass=1ƽ�ȣ�2���ڣ�3������
end
end