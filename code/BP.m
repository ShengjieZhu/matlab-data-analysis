function Predict = BP(data,Fig3)
% Designed by ShengjieZhu 
% NAR������Ԥ��
% Input\Hidden Layer\Output Layer\Output


[m,~]=size(data);
x=0:1:m-1;
y=data(:,1);
y=y';

% hf2 = figure(2);
% set(hf2,'position',[1,1,1366/2,600]);
% subplot(2,2,[1 2]);
% plot(x,y);
% title('ԭʼ����ͼ');
% grid on;
% hold on;

numnum = 20; %Ԥ�����ݵĳ���
output = NARpredict(y,numnum);
Predict = output;
% figure;
axes(Fig3);cla reset;

xFor = [x (length(x):length(x)+length(output)-1)];
yFor = [y output];
% plot(x,y);
plot(xFor(1:length(x)),yFor(1:length(x)),'r');hold on;
plot(xFor(length(x):end),yFor(length(x):end),'b');

xlabel('timeindex')
ylabel('timeseries')
title('Nonlinear autoregressive neural network');
legend(["Observed" "Forecast"],'Location','SouthEast')

end


