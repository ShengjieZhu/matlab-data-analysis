function ErrorList1 = setmonth_on_month(data,ts,t0,SubFig3)
% r(t) = [x(t) + x(t-1) + �� + x(t-w+1)]/ [x(t-w) + x(t-w-1) + �� + x(t-2w+1)]
%����

axes(SubFig3);
cla reset;
w = 5;
L = length(data);
for i =2*w:L  %��ΪҪ��֮ǰ�ľ�ֵ�Ƚϣ����Դ�2*w��ʼ����
    n(i)=mean(data(i-w+1:i))/mean(data(i-2*w+1:i-w));
end

if ts == 1
    n0 = autothresholdlow(n,t0);   %ѧϰ����ֵ
    n1 = autothresholdhigh(n,t0);  %ѧϰ����ֵ
else
    n0 = 0.98;   %�̶�����ֵ
    n1 = 1.02;   %�̶�����ֵ
end

ErrorList1=[];

for i =2*w:L
    if n(i)<n0 || n(i)>n1
         plot(i,n(i),'rx');
         hold on;
         ErrorList1 = [ErrorList1 i];
    end
end
p1 = plot(i,n(i),'rx');hold on;
p2 = plot([1 L],[n0 n0],'r--');hold on;
p3 = plot([1 L],[n1 n1],'k--');hold on;
p4 = plot(n);  
axis([1 L 0.9 1.02]); 
xlabel('����ʱ��');
ylabel('r�ռ�');
legend([p1,p2,p3,p4],'�쳣��','Min��ֵ','Max��ֵ','Z����');
end