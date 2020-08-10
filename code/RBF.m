function ErrorList2 = RBF(data,Fig2_1,Fig2_2,Fig2_3,Fig2_4)

%ѵ����������
y = data;%��ȡ����
x = 1:length(y);

n1 =zeros(20,length(y)/2-20);%������������
for n=1:length(y)/2-20
    column=zeros(1,20);
    for i=1:20
        column(i)=y(n+i);
    end
    n1(:,n)=column;
end
x1 = zeros(1,length(y)/2-20);%�����������
for n=1:length(y)/2-20
    x1(n)=y(n+20);
end
xn_train = n1; % ѵ������
dn_train = x1; % ѵ��Ŀ��
P = xn_train;
T = dn_train;
goal = 0.05; % ѵ������ƽ����(Ĭ��Ϊ0)
spread = 10; % ��ֵԽ��,��Ҫ����Ԫ��Խ��(Ĭ��Ϊ1)
MN = size(xn_train,2); % �����Ԫ��(Ĭ��Ϊѵ����������)
DF = 1; % ��ʾ���(Ĭ��Ϊ25)

normalnet = newrb(P,T,goal,spread,MN,DF);
%����
%��Ϻ��������Ԥ����������
% figure(1)

axes(Fig2_2);cla reset;
ytest1=data;
ytest_p=zeros(20,length(y)-20);%����Ԥ������
for n=1:length(y)-20
    column=zeros(1,20);
    for i=1:20
        column(i)=y(n+i);
    end
    ytest_p(:,n)=column;
end
yout=zeros(1,length(y));
% ǰ20����Ĭ����ʵ�ʲ�����ͬ���ӵ�21���㿪ʼԤ��
for i=1:20
    yout(i)=ytest1(i);
end
for i=21:length(yout)
    yout(i)=sim(normalnet,ytest_p(:,i-20));
end
t=[0:0.2/length(yout):0.2-0.2/length(yout)];
plot(t,yout);
hold on;
n=[0:0.2/length(yout):(length(ytest1)-1)*0.2/length(yout)];
plot(n,ytest1,'r');hold on;
legend('Ԥ�Ⲩ��','ʵ�ʲ���')

axes(Fig2_3);cla reset;
dif = yout'-ytest1;
plot(n,yout'-ytest1,'b');
title('Ԥ���ֵ');

axes(Fig2_4);cla reset;
normplot(dif);%��XΪ����������ʾ��̬�ֲ�����ͼ�Σ���XΪ��������ʾÿһ�е���̬�ֲ�����ͼ��
              %�������������̬�ֲ�����ͼ����ʾΪֱ�ߣ��������ֲ�������ͼ�в���������
[muhat,sigmahat,muci,sigmaci] = normfit(dif,0.90);%muhat,sigmahat�ֱ�Ϊ��̬�ֲ��Ĳ����̺ͦҵĹ���ֵ��,muci,sigmaci�ֱ�Ϊ������,�����Ŷ�Ϊ��0.95
%disp(pd);
section = sigmahat*2;       %Ӧ����3��׼������ΪЧ������2��

axes(Fig2_1);cla reset;
plot(x,y);
hold on;
ErrorList2=[];
for i=1:length(x)
    if abs(dif(i))>=section
        plot(i,y(i),'x','Color',[1 0 0]);hold on;
        ErrorList2 = [ErrorList2 i];
    end
end
title('ԭʼ�����쳣ֵ��ǵ�ͼ');
grid on;

end