function n1 = autothresholdhigh(n,t0,SubFig2)
n = n.* -1;
[f,x] = ecdf(n);
x = x.* -1;
L = length(f);
i = 1;
while f(i) <= t0
    i = i + 1;
end
n1 = x(i-1);

switch nargin
    case 3
%       hax = varargin{1};
        axes(SubFig2);
        plot(x,f,'r');
        hold on
        plot([n1 n1],[0 1],'r--');
        legend('�����ۻ���������','������ֵ','�澭���ۻ���������','�������ֵ');
        title('ECDF����');
        xlabel('ƽ��������ֵ');
        ylabel('���ʣ�%')
    otherwise
end
end