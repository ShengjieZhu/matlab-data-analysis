function ErrorList1 = setyear_on_year(data,ts,t0,varargin)
% Z(t) = {x(t) �C mean[x(t-kT-w):x(t-kT+w)]}/std(x(t-kT-w):x(t-kT+w))
%ͬ��

hax = varargin{1};
global period               
k = 1;
w = 1;
g = period + w + 1;   %��ΪҪ��֮ǰ�ľ�ֵ�ͱ�׼��Ƚϣ����Դ�period + w + 1��ʼ����
L = length(data);
for i = g:L
    n(i) =((data(i)-mean(data(i-k*period-w : i-k*period+w)))/std(data(i-k*period-w : i-k*period+w)));
end

if ts == 1
    n0 = autothresholdlow(n,t0);  %ѧϰ��ֵ
else
    n0 = -5;                      %�̶���ֵ
end
ErrorList1=[];
axes(hax);
cla reset;

for i = g:L
    if n(i)<n0 
        p1 = plot(i,n(i),'rx','parent',hax);
        hold on;
        ErrorList1 = [ErrorList1 i];
        hold on
    end
end
p2 = plot([1 L],[n0 n0],'r--');hold on;
p3 = plot(n);hold on;
xlabel('����ʱ��');
ylabel('z�ռ�');
legend([p1,p2,p3],'�쳣��','��ֵ','Z�ռ�����');
end

