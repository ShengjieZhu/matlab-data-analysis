function ErrorList1 = setthreshold(data,ts,t0,SubFig2,SubFig3)

axes(SubFig3);cla reset;
n = smooth(data); %smoothƽ������
p1 = plot(n);
hold on;


if ts == 1
    n0 = autothresholdlow(n,t0,SubFig2);%ѧϰ����ֵ
    n1 = autothresholdhigh(n,t0,SubFig2);%ѧϰ����ֵ
    
else
    n0 = 0;%�̶�����ֵ
    n1 = 2;%�̶�����ֵ
end

L = length(n);

% hax = varargin{2};
axes(SubFig3);
ErrorList1=[];
for i = 1:L
    if n(i)<n0 || n(i)>n1
        p2 = plot(i,n(i),'rx');
        hold on;
        ErrorList1 = [ErrorList1 i];
    end
end 
xlabel('����ʱ��');
ylabel('ƽ���������');
legend([p1,p2],'ƽ������','�쳣ֵ');
end