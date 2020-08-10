function Predict = LSTM(data,Fig3)

% Designed by ShengjieZhu
% ��ʾ��˵�����ʹ�ó��ڶ��ڼ��� (LSTM) ����Ԥ��ʱ�����ݡ�
% �˷�����ҪNVIDA GPU�������㣬������ҪNVIDAӲ��������֧�֡�

[m,~]=size(data);
x=0:1:m-1;
y=data(:,1);
y=y';
data=y;

numTimeStepsTrain = numel(data);
numTimeStepsTest = 30;
YPred = LSTMpredict(data,numTimeStepsTest);
Predict = YPred;
%% ʹ�� Ԥ��ֵ ���� ѵ��ʱ��
% figure
axes(Fig3);cla reset;

idx = (1:length(data));
plot(x(1)-1+idx,data);hold on
idx = numTimeStepsTrain:(numTimeStepsTrain+numTimeStepsTest);
plot(x(1)-1+idx,[data(numTimeStepsTrain) YPred],'.-');
hold off;grid on
xlabel('timeindex')
ylabel('timeseries')
title('���ڶ��ڼ��� (LSTM) ����');
legend(["Observed" "Forecast"],'Location','SouthEast')




function YPred = LSTMpredict(dataTrain,numTimeStepsTest)
%% ��׼������
% Ϊ�˻�ýϺõ���ϲ���ֹѵ����ɢ����ѵ�����ݱ�׼��Ϊ���� ���ֵ �� ��λ����
% ��Ԥ��ʱ��������ʹ�� ��ѵ��������ͬ�Ĳ��� ����׼�� ��������
mu = mean(dataTrain);
sig = std(dataTrain);

dataTrainStandardized = (dataTrain - mu) / sig;

%% ׼��Ԥ���������Ӧ
% ҪԤ�������ڽ���ʱ�䲽��ֵ���뽫��Ӧָ��Ϊ��ֵ��λ��һ��ʱ�䲽��ѵ�����С�
% Ҳ����˵�����������е�ÿ��ʱ�䲽��LSTM ���綼ѧϰԤ����һ��ʱ�䲽��ֵ��
% Ԥ�������û������ʱ�䲽��ѵ�����С�

XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);


%% ���� LSTM ����ܹ�
% ���� LSTM �ع����硣
% ָ�� LSTM ���� 200 ��������Ԫ��

numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];

% ָ��ѵ��ѡ�
% �����������Ϊ 'adam' ������ 250 ��ѵ����
% Ҫ��ֹ�ݶȱ�ը���뽫�ݶ���ֵ����Ϊ 1��
% ָ����ʼѧϰ�� 0.005���� 125 ��ѵ����ͨ���������� 0.2 ������ѧϰ�ʡ�

options = trainingOptions('adam', ...
    'MaxEpochs',250, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',125, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0, ...
    'Plots','training-progress');


%% ѵ�� LSTM ����
% ʹ�� trainNetwork ��ָ����ѵ��ѡ��ѵ�� LSTM ���硣

net = trainNetwork(XTrain,YTrain,layers,options);


%% Ԥ�⽫��ʱ�䲽
% ҪԤ�⽫�����ʱ�䲽��ֵ��
% ��ʹ�� predictAndUpdateState ����һ��Ԥ��һ��ʱ�䲽��
% ����ÿ��Ԥ��ʱ��������״̬��
% ����ÿ��Ԥ�⣬ʹ��ǰһ��Ԥ����Ϊ���������롣

% ��ʼ������״̬
% ��ѵ������ XTrain ����Ԥ�⡣
net = predictAndUpdateState(net,XTrain);
% ��ѵ����Ӧ�����һ��ʱ�䲽 YTrain(end) ���е�һ��Ԥ�⡣
% ѭ������Ԥ�Ⲣ��ǰһ��Ԥ�����뵽 predictAndUpdateState��
[net,YPred] = predictAndUpdateState(net,YTrain(end));
% ���ڴ������ݼ��ϡ������л�������磬�� GPU �Ͻ���Ԥ�����ͨ������ CPU �Ͽ졣
% ��������£��� CPU �Ͻ���Ԥ�����ͨ�����졣
% ���ڵ�ʱ�䲽Ԥ�⣬��ʹ�� CPU��
% Ҫʹ�� CPU ����Ԥ�⣬�뽫 predictAndUpdateState �� 'ExecutionEnvironment' ѡ������Ϊ 'cpu'��
for i = 2:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
end

% ʹ�� ��ǰ����Ĳ��� �� Ԥ�� ȥ��׼����
YPred = sig*YPred + mu;
end
end
