clear;
clc;
%������ ���������� ����������� ��-� � ������� �����������(PDE);
global ep; 
ep=0.5;%�������

r=2; %�������� ��������
s=6; %���������� ��������

global N; 
N=20;%����� �������� �� �
M=20;% ����� �������� �� �������
global h;
a=1;
h=2/N;%��������� �� � 
aa=(1+1i)/2;% ���������� ����� ����������

 
for m=1:1:s
    m                                                            %mmm
    tau=1.5/M;%��������� ������� �� ��������
    h=2/N;%��������� �� � 
    n=0;%���������� �����
    UU=[];
    U=[];
    %���� ��� ��������� ���������� �����������
    for k=-1:h:1
        n=n+1;
      
        U(1,n)=6*tanh(k/ep);
    end
    UU(1,:)=U(1,:);
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
        w=real((inv(eye(N-1)-aa*tau*Y))*F);
        w=w';%������� w
        
        U(n+1,2:N)=U(n,2:N)+tau*w;%���������� ����� �������� � U
        U(n+1,1) = -6 + sin(4*3.14159265359*t(n)) ;
        U(n+1,N+1) =6-2*sin(4*3.14159265359*t(n)) ;
        
                
        if m > 1
            if rem(n,a)== 1
                j=j+1;
                
                UU(j+1,:)=U(n+1,:);
                TT(m,j)=n;
             end
        else 
        UU(n+1,:)=U(n+1,:);    
        end
        
        if n == M
        UU(20+1,:)=U(n+1,:);
        end
    end
    ii=0;
    for i= 1:1:N
        if m > 1
        if rem(i,a)== 1
            ii=ii+1;
            u(:,ii,m)=UU(:,i);
            X(m,ii)=i;
        end
        
        else 
        u=UU;
        end
    end
    
    u(:,20+1,m)=UU(:,N+1);
    a=a*r;
    K(m)=n;
    N=N*r;
    M=M*r;

end
pogr;