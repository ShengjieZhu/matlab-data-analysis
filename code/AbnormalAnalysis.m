function [DataClass,ErrorList1] = AbnormalAnalysis(SourceData,ts,t0,n0,WaveletMethod,Fig1_2,Fig1_3);
%���������ݷ����3������������쳣ֵ��
%data:����
%ts:�Ƿ�ʹ��ѧϰ��ֵ��1���� 0������
%t0:%������ֵ

SubFig2 = Fig1_2;
title(SubFig2,'�����Ƿ�Ϊ����ͼ��');
SubFig3 = Fig1_3;
title(SubFig3,'Ԥ��λ�ñ��ͼ');

%% ���ݷ�����DataClass=1ƽ�ȣ�2���ڣ�3������
DataClass = DataClassifier(SourceData,n0,WaveletMethod,SubFig2);
switch DataClass
    case 1
        ErrorList1 = setthreshold(SourceData,ts,t0,SubFig2,SubFig3);           %ƽ��������
    case 2
        ErrorList1 = setyear_on_year(SourceData,ts,t0,SubFig3);              %��������
    case 3
        ErrorList1 = setmonth_on_month(SourceData,ts,t0,SubFig3);            %����������
end
end