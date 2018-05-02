clear;
clc;
%������ ���������� ����������� ��-� � ������� �����������(PDE);
global ep; 
ep=0.5;%�������

r=2; %�������� ��������
s=5; %���������� ��������

global N; 
N=100;%����� �������� �� �
M=100;% ����� �������� �� �������
global h;
a=1;
h=2/N;%��������� �� � 
aa=(1+1i)/2;% ���������� ����� ����������

 
for m=1:1:s
    m                                                            %mmm
    tau=1.5/M;%��������� ������� �� ��������
    h=2/N;%��������� �� � 
    n=0;%���������� �����
    U=[];
    %���� ��� ��������� ���������� �����������
    for k=-1:h:1
        n=n+1;
      
        U(1,n)=6*tanh(k/ep);
    end
   
    n=0;%���������� ����� �������
    j=0;
   
    %���� �����
     for k=0:tau:1.5
     n=n+1;
     t(n)=k;
     end
    for n= 1:M   
        t(n)%������� �����
       m
        Y=Yak(U(n,2:N),t(n));%������� ������� �����
        F=Fuu(U(n,2:N),t(n)+tau/2);%������� ������ �������� ������� 
        w=TridiagonalMatrixAlgorithm(eye(N-1)-aa*tau*Y,F);
     w=real(w);
        w=w';%������� w
        
        U(n+1,2:N)=U(n,2:N)+tau*w;%���������� ����� �������� � U
        U(n,1) = -6 + sin(4*3.14159265359*t(n)) ;
        U(n,N+1) =6-2*sin(4*3.14159265359*t(n)) ;
        
                
TT(n+1,m)=t(n+1); %��� �������
        end
   n=0;%�������
   
    for i = 1:a:N+1  % ����� �� �
        n=n+1;
        k=0;
        for j =1:a:M+1 % ����� �� �������
            k=k+1;
            u(k,n,m)=U(j,i);
            TTT(k,m)=TT(j,m); %����������� ������� �������
        end
    end
      
    a=a*r; %���������� ��� ��������� ��������
%     K(m)=n;
    N=N*r; %���������� � � �������
    M=M*r;
 end

 pogr;
