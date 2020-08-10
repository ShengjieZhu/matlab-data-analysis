function ClassFlag = Periodicity(SourceData,SubFig2)

n0 = 0.1;                            % ��ֵ��ֵ
k = 5;                               %���̶�
n1 = 10;                             %�ж�������ֵ
L = length(SourceData);
T = 1/139;
t = (0:L-1)*T;                       % ʱ��
y = SourceData;
Fs = 1/T;
N = 2^nextpow2(L);                      %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
Y = fft(y,N)/N*2;                       %����N����2������ʵ��ֵ��NԽ�󣬷�ֵ����Խ��
f = Fs/N*(0:1:N-1);                     %Ƶ��
A = abs(Y);                             %��ֵ

axes(SubFig2);
cla reset;

p1 = plot(f(1:N/2),A(1:N/2),'parent',SubFig2);   %����fft����ֵ�����ݽṹ���жԳ���,�������ֻȡǰһ��
hold on

f1 = f(1:N/2);
[LOCS,PKS]=myfindpeaks(A(1:N/2),'',k,n0);
am1 = PKS;
pv1 = f1(LOCS);
p2 = plot(pv1,am1,'r*','parent',SubFig2); 
legend(SubFig2,[p1,p2,],'����Ƶ��','����ֵ');
[a,b] =max(am1);
global period
period = round(pv1(b));    %�������ݵ�����

tmp = diff(pv1);
tmp = diff(tmp);

g = sum(abs(tmp));
if g < n1
    ClassFlag = 1;
    title(SubFig2,'�����Ƿ�Ϊ����ͼ�Σ��ǣ�');
else
    ClassFlag = 0;
    title(SubFig2,'�����Ƿ�Ϊ����ͼ�Σ���');
end
    
end