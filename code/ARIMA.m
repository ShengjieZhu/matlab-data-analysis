function Predict = ARIMA(data,Fig3)

% ARIMAģ��
% Designed by ShengjieZhu 

[m,~]=size(data);
x=0:1:m-1;
y=data(:,1);
y=y';
% hf2 = figure;

axes(Fig3);cla reset;
% set(hf2,'position',[1,1,1366/2,600]);
plot(x,y);
title('autoregressive integrated moving average')
grid on;
hold on;

aaa = y';

% ���� 1 �ײ��
diff_a=diff(aaa);

% arima_i=0;
% diff_a=aaa(2:length(aaa));
% y_h_adf = adftest(aaa);
% y_h_kpss=kpsstest(aaa);
% while y_h_adf==0||y_h_kpss ==1
%     diff_a=diff(aaa);
%     arima_i=arima_i+1;
%     if arima_i>5
%         break;
%     end
% end

temp=ar(diff_a,2,'ls');  %������С���˷�����ģ�͵Ĳ���
predict_diff_a=predict(temp,diff_a);  %��ԭʼ���ݵ�Ԥ��ֵ,�ڶ�����������Ϊ������
plot(x,[aaa(1); aaa(1:end-1)+predict_diff_a],'LineWidth',0.2);

% Ԥ��ֵ�ĸ��� >0
predict_num = 30;
Predict_a = arima_forcast(aaa,predict_num);
Predict = Predict_a';
plot(x(end)+(1:length(Predict_a)),Predict_a,'LineWidth',1,'Color',[0 1 1]);
legend('actual','predict by Autoregressive','forecast by arima','Location','SouthEast')


%% autoregressive integrated moving average
function predict_a = arima_forcast(aaa,predict_num)
% У���ȶ���������
% diff_a=diff(aaa);

arima_i=0;
y_h_adf = adftest(aaa);
y_h_kpss=kpsstest(aaa);
while y_h_adf==0&&y_h_kpss ==1
    diff_a=diff(aaa);
    arima_i=arima_i+1;
    if arima_i>5
        break;
    end
end


[r,m] = decide_order(diff_a,arima_i);

%% Mdl = arima(p,D,q)
% ����һ��ARIMA(p,D,q)ģ��
% ��1��p�ķǼ�����AR����ʽ�ͺ�
% D�ηǼ����Ի��ֶ���ʽ�ͺ�
% ��1��q�ķǼ�����MA����ʽ�ͺ�
% Autoregressive Integrated Moving Average
spec2 = arima(r,0,m);

%% [EstMdl,EstParamCov,logL,info] = estimate(Mdl,y)
% ���ݹ۲쵽�ĵ�����ʱ������y
% ʹ�������Ȼ������ARIMA(p,D,q)ģ��Mdl�Ĳ���
% EstMdl �洢�����ARIMAģ��
% EstParamCov ����Ʋ�����صķ���-Э�������
% logL �Ż���loglikelihoodĿ�꺯��
[EstMdl,EstParamCov,logL] = estimate(spec2,diff_a,'Display','off');

%% Y = forecast(Mdl,numperiods,Y0,Name,Value) 
% ʹ����ȫָ����VAR(p)ģ��Mdl�������ڳ���numperiodsԤ�ⷶΧ�ڵ�
% ��С�������(MMSE)Ԥ��(Y)·����
% Ԥ�����Ӧ����Ԥ��������Y0��������
% �� w ��Ԥ��ֵ
w_Forecast = forecast(EstMdl,predict_num,'Y0',diff_a);

%% ����ԭʼ���ݵ�Ԥ��ֵ
predict_a=aaa(end)+cumsum(w_Forecast);
end

function [r,m] = decide_order(diff_a,arima_i)
% ���� AIC ׼�򶨽�
% �����ֺ�����ݸ���
length_diff_a=length(diff_a);
% ��ʼ����С�� aic
aicmin=inf;
for i=0:3
    for j=0:3
        % ָ��ģ�͵Ľṹ
        spec = arima(i,arima_i,j);
        % ��ϲ���
        [~,EstParamCov,logL] = estimate(spec,diff_a,'Display','off');
        % ������ϲ����ĸ���
        numParams = sum(any(EstParamCov));
%         ���� Akaike and Bayesian Information Criteria
%         [aic,bic] = aicbic(logL,numParam,numObs) 
%         logL �Ż���loglikelihood����ֵ
%         the sample sizes associated with each logL value
        [aic,bic]=aicbic(logL,numParams,length_diff_a);
        % ��ʾ������
        fprintf('R=%d,M=%d,AIC=%f,BIC=%f\n',i,j,aic,bic);
        % ���� aic ��С������ R �� M
        if aic<aicmin
            aicmin = aic;
            r=i;    m=j;
        end
    end
end
end
end