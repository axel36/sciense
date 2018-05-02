clear;
clc;
%������ ��������� ���������� �������;

%------------------������� ����������� ����������--------------------------
%global m;
m_pov=3;
%global p;     %���������� ��� ������ ������: ������� U � ����� �������
p=3;
global L;
L=5;
%global N; 
N=50;%����� �������� �� �
M=50;% ����� �������� �� �������
%global h;
h=L/N;%��������� �� � 
tt=3;%�����
tau=tt/M;%��������� ������� �� ��������
aa=(1+1i)/2;% ���������� ����� ����������

%-----------------������� ����������� ��������-----------------------------
a=pi/4;             
A=sin(3*a)^5+((-5)*m_pov*a*cos(3*a)*(sin(3*a)^4))^(1/(p-m_pov+1));
M_0=M;
N_0=N;

%------------------------------��������------------------------------------
r_x=2; %�������� ��������
r_t=2;

S=8; %���������� ��������
var_x=1; %
var_t=1; %
%----------------------------���� ���������--------------------------------

u=zeros(M_0,N_0,S);

for s=1:1:S
      %�����
   Mat=ones(1,N);%��������� ������� ��� ����� ����������
    Mat(N)=0;
    tau=tt/M;%��������� ������� �� ��������
    h=L/N;%��������� �� � 
    n=0;%�������
    U = zeros(1,N+1);%�������� ������ � ���������
    X = zeros(1,N+1);
    %���� ��� ��������� ���������� �����������
    for k=0:h:L
   
        n=n+1;
        X(n)=k;%������ � ����������
        if k<2
            %U(1,n)=A;                  %��� ������� �������
            U(1,n)=A;  
        else
            U(1,n)=A-(sin(a*(k-1))^5);%��������� �����������
        end
    end
%��������� ������� ����� �� �
    if s==1
         X_0 = X;
    end
%plot(X,U(1,:),'-*r','MarkerSize',3,'LineWidth',1);
n=0;%���������� ����� �������
t=zeros(1,tt/tau);
 for k=0:tau:tt
     n=n+1;
     t(n)=k;
 end
% ��������� ������� ����� �� �
 if s==1
    T_0=t;
 end
    
    
    %-----------������ ��� ������ �������� ����� N_0 X M_0-----------------
    n=0;%�������
    I=zeros(1,N+1);
    J=zeros(1,M+1);
   for i = 1:var_x:N+1  % ����� �� �
        n=n+1;
        I(n)=i;
   end
   n=0;%�������
   for j = 1:var_t:M+1  % ����� �� �
        n=n+1;
        J(n)=j;
   end
 %-------------------------------------------------------------------------
 %
 %
 for k = 1:(N_0 + 1) 
            u(1,k,s) = U(I(k)); 
 end 
 i=2;
%-----------------------------���� �����-----------------------------------
 for n= 1:M  
        s
        n
        M
        
     %Y=Yak(U(2:N+1));%������� ������� �����
     F=Fuu(U(2:N+1),N,m_pov,p,h);%������� ������ �������� ������� 
%      F=F';
%     w=TridiagonalMatrixAlgorithm(Mat-aa*tau*Y,F);%w=A^(-1)*F
     


%      AA=Mat-aa*tau*Y;
%      coeff=AA(N-1,N-2)/AA(N,N-2);
%      AA(N,N-2)=0;   
%      AA(N,N-1)=AA(N-1,N-1)-coeff*AA(N,N-1);
%      AA(N,N)=AA(N-1,N)-coeff*AA(N,N);
     
        [a_w b_w c_w coeff]=Prepares_beforeNew_tridalgorithm(U(2:N+1),aa,tau,Mat,N,m_pov,p,h);

       F(N)=F(N-1)-coeff*F(N);
     
     
     
     w=TridiagonalMatrixAlgorithm(a_w, b_w, c_w,F);
%       ww=TridiagonalMatrixAlgorithm(a_w, b_w, c_w,F);
%       if (sum(w)~= sum(ww))
%           break
%       end
%     w=A^(-1)*F;
     w=real(w);
     w=w';%������� w
      
     
     
     U(2:N+1)=U(2:N+1)+tau*w;%���������� ����� �������� � U
     U(1) = ((4*U(2)^m_pov-U(3)^m_pov)/3)^(1/m_pov) ;
     
     % plot(X,U,'-*r','MarkerSize',3,'LineWidth',1);
     
     if n+1 == J(i)
         
        for k = 1:(N_0 + 1) 
            u(i,k,s) = U(I(k)); 
        end 
        
        i=i+1;
     end
     
     
%     U(n+1,N+1) =6-2*sin(4*3.14159265359*t(n)); %�� ����� � ���� ���������
  %  TT(n+1,s)=t(n+1); %��� �������
    
 end
  %graf;
%------------------------------����� �����---------------------------------
%  %������ ������
%    n=0;%�������
%    for i = 1:var_x:N+1  % ����� �� �
%         n=n+1;
%         k=0;
%         for j =1:var_t:M+1 % ����� �� �������
%             k=k+1;
%             u(k,n,s)=U(j,i);
%             TTT(k,s)=TT(j,s); %����������� ������� �������
%         end
%     end
%       
    var_x=var_x*r_x; %���������� ��� ��������� ��������
     var_t=var_t*r_t;
%     K(m)=n;
    N=N*r_x; %C������� ����� � � �������
    M=M*r_t;
end
    
save('10_Ex_2a');
TemplateForBlowUpDiagnostics;
