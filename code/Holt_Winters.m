function ErrorList2 = Holt_Winters(data,alpha,Fig2_1,Fig2_2,Fig2_3,Fig2_4)
% Holt-Winterָ��ƽ���� 
% Designed by ShengjieZhu
% Modified by xufei on 2020/6/2

[m,~]=size(data);
x=0:1:m-1;
y=data(:,1);

axes(Fig2_1);
cla reset;
plot(x,y);
title('ԭʼ����ͳ��ͼ');
grid on;

yAct=data;n=length(yAct);
sub=0;
% alpha=0.3;
sub=sub+1;
st1_0=mean(yAct(1:3)); st2_0=st1_0;st3_0=st1_0; 
st1(1)=alpha*yAct(1)+(1-alpha)*st1_0; 
st2(1)=alpha*st1(1)+(1-alpha)*st2_0; 
st3(1)=alpha*st2(1)+(1-alpha)*st3_0; 
for i=2:n
    st1(i)=alpha*yAct(i)+(1-alpha)*st1(i-1);    
    st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1); 
    st3(i)=alpha*st2(i)+(1-alpha)*st3(i-1);
end
a=3*st1-3*st2+st3; 
b=0.5*alpha/(1-alpha)^2*((6-5*alpha)*st1-2*(5-4*alpha)*st2+(4-3*alpha)*st3);
c=0.5*alpha^2/(1-alpha)^2*(st1-2*st2+st3); 
yFor=a+b+c;

axes(Fig2_2);cla reset;
plot(1:n,yAct,1:n,yFor(1:n));
title('Ԥ��������ԭʼ���ݶԱ�ͼ');
grid on;
legend('Actual','Forecast');

var = 1/n*sum((yAct'-yFor(1:n)).^2);%����
%disp(yhat)
for i=1:n
    dif(i) = yFor(1,i)-yAct(i,1);
end
% disp(dif)

axes(Fig2_3);cla reset;
histogram(dif,1000);
histfit(dif);
pd = fitdist(dif','Normal');
title('��ֵ�ֲ�ֱ��ͼ');
grid on;

axes(Fig2_4);cla reset;
normplot(dif);%��XΪ����������ʾ��̬�ֲ�����ͼ�Σ���XΪ��������ʾÿһ�е���̬�ֲ�����ͼ��
              %�������������̬�ֲ�����ͼ����ʾΪֱ�ߣ��������ֲ�������ͼ�в���������
[muhat,sigmahat,muci,sigmaci] = normfit(dif,0.95);%muhat,sigmahat�ֱ�Ϊ��̬�ֲ��Ĳ����̺ͦҵĹ���ֵ��,muci,sigmaci�ֱ�Ϊ������,�����Ŷ�Ϊ��0.95
%disp(pd);
section = sigmahat*2;       %Ӧ����3��׼������ΪЧ������2��

axes(Fig2_1);cla reset;
plot(x,y);
hold on;

ErrorList2=[];
for i=1:n
    if abs(dif(i))>=section
        plot(i-1,y(i),'x','Color',[1 0 0]);
        ErrorList2 = [ErrorList2 i];
    end
end

title('ԭʼ�����쳣ֵ��ǵ�ͼ');
grid on;


