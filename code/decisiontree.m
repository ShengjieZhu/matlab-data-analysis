function decisiontree(DataClass,ts,t0,n0,WaveletMethod,alpha,ErrorList1,ErrorList2,FuncChoose,Predict,HR)
% д����־
% ���͸��û�
% ִ����һ������
switch DataClass
    case 1
        DataClass="��ȡ����������Ϊ��ƽ������";
    case 2
        DataClass="��ȡ����������Ϊ����������";
    case 3
        DataClass="��ȡ����������Ϊ������������";
end

fid =fopen('../log/data.log','a');
t=datetime('now','TimeZone','local','Format','d-MM-y HH:m:ss z');
fprintf(fid,'\n%s\n',t);
fprintf(fid,'%s\n',DataClass);

if ts
    fprintf(fid,'�Ƿ�ʹ��ѧϰ��ֵ����\n');
else
    fprintf(fid,'�Ƿ�ʹ��ѧϰ��ֵ����\n');
end
fprintf(fid,'������ֵΪ��%f\n�ȶ����ж���ֵ��%f\n���β��õķ����ǣ�%s\n',t0,n0,WaveletMethod);
fprintf(fid,'Holt-Winters�������ã�alpha=%f\n',alpha);

fprintf(fid,'�̶�/ѧϰ��ֵ�����쳣�����õ��Ĵ������ݱ��:\n');
fprintf(fid,'%s\n',num2str(ErrorList1));
if (HR)
    fprintf(fid,'������-���أ�Holt-Winters�������쳣�����õ��Ĵ������ݱ��:\n');
else
    fprintf(fid,'�����������RBF�����磩�����쳣�����õ��Ĵ������ݱ��:\n');
end
fprintf(fid,'%s\n',num2str(ErrorList2));

switch FuncChoose
    case 1
        fprintf(fid,'��������Ԥ�⣺����Autoregressive Integrated Moving Average modelģ�ͽ���Ԥ��\n');
        fprintf(fid,'Ԥ�⽫������Ϊ��%s\n',num2str(Predict));
    case 2
        fprintf(fid,'��������Ԥ�⣺����Back Propagation Neural Networkģ�ͽ���Ԥ��\n');
        fprintf(fid,'Ԥ�⽫������Ϊ��%s\n',num2str(Predict));
    case 3
        fprintf(fid,'��������Ԥ�⣺����Long short-term memory,LSTMģ�ͽ���Ԥ��\n');
        fprintf(fid,'Ԥ�⽫������Ϊ��%s\n',num2str(Predict));
    otherwise
        fprintf(fid,'��������Ԥ�⣺δʹ��ģ�ͽ���Ԥ��\n');
end

fclose(fid);


end