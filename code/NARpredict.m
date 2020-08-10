function output = NARpredict(input,numnum)
%inputΪԭʼ���У���������

lag=3;    % �Իع����
n=length(input);

%׼��������������
inputs=zeros(lag,n-lag);
for i=1:n-lag
    inputs(:,i)=input(i:i+lag-1)';
end
targets=input(lag+1:end);

%��������
hiddenLayerSize = 10; %���ز���Ԫ����
net = fitnet(hiddenLayerSize);

% �������ϣ�����ѵ�������Ժ���֤���ݵı���
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

%ѵ������
[net,tr] = train(net,inputs,targets);
%% ����ͼ���ж���Ϻû�
yn=net(inputs);
errors=targets-yn;
figure;
ploterrcorr(errors);                      %������������������20lags��
figure;
parcorr(errors);                          %����ƫ������
[h,pValue,stat,cValue]= lbqtest(errors);         %Ljung��Box Q���飨20lags��
figure;
plotresponse(con2seq(targets),con2seq(yn));  %��Ԥ���������ԭ����
figure;
ploterrhist(errors);                      %���ֱ��ͼ
figure;
plotperform(tr);                          %����½���


%% ����Ԥ������Ԥ�⼸��ʱ���
%Ԥ�ⲽ��Ϊfn
f_in=input(n-lag+1:end)';
output=zeros(1,numnum);  %Ԥ�����
% �ಽԤ��ʱ���������ѭ�������������������
for i=1:numnum
    output(i)=net(f_in);
    f_in=[f_in(2:end);output(i)];
end
end