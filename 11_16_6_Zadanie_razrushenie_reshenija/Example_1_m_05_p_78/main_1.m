clear;
clc;
%������ ��������� ���������� �������;
%-----------------������� ����������� ��������-----------------------------
m_pov=1/2;
          %���������� ��� ������ ������: ������� U � ����� �������
          
%pim= 3.141592653589793;
p=7/8;
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
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
a=3*pi/3.5;             
A=sin(3*a)^5+((-5)*m_pov*a*cos(3*a)*(sin(3*a)^4))^(1/(p-m_pov+1));
M_0=M;
N_0=N;
%------------------------------��������------------------------------------
r_x=2; %�������� �������� �� �
r_t=2; % �� t
S=4; %���������� ��������
var_x=1; %
var_t=1; %
%--------------------------------------------------------------------------
%----------------------------���� ���������--------------------------------
u=zeros(M_0,N_0,S);
for s=1:1:S
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
            U(1,n)=A;  
        else
            U(1,n)=A-(sin(a*(k-1))^5);%��������� �����������
        end
    end
    if s==1
       X_0 = X; %��������� ������� ����� �� �
    end
    %plot(X,U(1,:),'-*r','MarkerSize',3,'LineWidth',1);
    t=zeros(1,tt/tau);
    n=0;%���������� ����� �������
    for k=0:tau:tt
        n=n+1;
        t(n)=k;
    end
    if s==1
        T_0=t; % ��������� ������� ����� �� �
    end
 %--------------������ ��� ������ �������� ����� N_0 X M_0-----------------
    n=0;%�������
    I=zeros(1,N+1);
    J=zeros(1,M+1);
    for i = 1:var_x:N+1  % ����� �� �
        n=n+1;
        I(n)=i;
    end
    n=0;%�������
    for j = 1:var_t:M+1  % ����� �� t
        n=n+1;
        J(n)=j;
    end
 %-------------------------------------------------------------------------
    for k = 1:(N_0 + 1) 
        u(1,k,s) = U(I(k)); %����� ������ ��������� ����
    end 
    i=2;
%-----------------------------���� �����-----------------------------------
    for n= 1:M  
        s
        n
        M
        %Y=Yak(U(2:N+1));%������� ������� �����
        F=Fuu(U(2:N+1),N,m_pov,p,h);%������� ������ �������� ������� 
        %F=F';
        [a_w b_w c_w coeff]=Prepares_beforeNew_tridalgorithm(U(2:N+1),aa,tau,Mat,N,m_pov,p,h);
        F(N)=F(N-1)-coeff*F(N);
        w=TridiagonalMatrixAlgorithm(a_w, b_w, c_w,F);
        w=real(w); %       w=A^(-1)*F;
        w=w';%������� w
        U(2:N+1)=U(2:N+1)+tau*w;%���������� ����� �������� � U
        U(1) = ((4*U(2)^m_pov-U(3)^m_pov)/3)^(1/m_pov) ;
              
%       plot(X,U,'-*r','MarkerSize',3,'LineWidth',1);
        if n+1 == J(i)
            for k = 1:(N_0 + 1) 
                u(i,k,s) = U(I(k)); 
            end 
            i=i+1;
        end
%       TT(n+1,s)=t(n+1); %��� �������
%   graf;
%------------------------------����� �����---------------------------------

    end
    var_x=var_x*r_x; %���������� ��� ��������� ��������
    var_t=var_t*r_t;
    
    N=N*r_x; %C������� ����� � � �������
    M=M*r_t;
end
%save('9_with_new_M');
% for s=1:S
% figure;
% for n=1:M
%  
%     txt2=num2str(n);
%     txt1='t =';
%     txt=[txt1 ' ' txt2] ;
%     plot(X,Line,'--black','LineWidth',2);
%     hold on;
%     plot(X,u(n,:,s),'-or','MarkerSize',3,'LineWidth',1);
%     axis([0 5 0 10]);
%     hT = text(2.5, 3,txt); 
%     %hT = text(-0.6, 6.5,'epsilon = 0.05'); 
%     xlabel('x \in (0,5)'); 
%     ylabel('u'); 
%     drawnow;
%    hold off;
%    pause(0.07);
%     %mov(n) = getframe;
%     
% end
% close('all');



 B1=u(:,:,1);
 B2=u(:,:,2);
 B3=u(:,:,3);
 B4=u(:,:,4);
TemplateForBlowUpDiagnostics;
