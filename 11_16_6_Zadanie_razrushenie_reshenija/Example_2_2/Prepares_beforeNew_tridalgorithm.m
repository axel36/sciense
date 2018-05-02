function [ a b c coeff] = Prepares_beforeNew_tridalgorithm( u,aa,tau,Mat,N,m,p,h )
%PREPARES_BEFORENEW_TRIDALGORITHM Summary of this function goes here
% �������, ������� �������������� �������, ������� �������� ��������� ������� �������� ������� ���
% ������ ������� ����� ��� [M - (1+1i)/2*tau*f_u] � �������� ���������������

% �������� ����������� ��������:
% u - ������� ������� ��� � ������� ������ ������� (����� ��������� �����) 
%  tau - ������� ��� �� �������
% aa - ����������� �������� ����� ���������� -(1+1i)/2
% ��t - ��������������� �������� (������ ������ ������� �)
% �������� ���������:
% a, b � c - ��������������� �������
%
%  [ a(1)  c(1)                           ] 
%  [ b(2)  a(2)  c(2)                     ] 
%  [       b(3)  a(3)  c(3)               ] 
%  [            ...   ...   ...           ] 
%  [                    ...    ...  ...   ] 
%  [                          b(N)  a(N)  ] 
%-------------------------------------------------------------------------%
% global N;
% global m;
% global p;
% global h;

    a = zeros(N ,1);
    b = zeros(N ,1);
    c = zeros(N ,1);
   % f = zeros(N ,1);
    
    
a(1,1) =Mat(1)-aa*tau*((-2*m*u(1)^(m-1))/(3*h*h));
c(1,1)=0-aa*tau*((2*m*u(2)^(m-1))/(3*h*h));
a(N,1)=Mat(N)-aa*tau*((p*u(N)^(p-1))- (3*m*u(N)^(m-1))/(2*h));
b(N,1)=0-aa*tau*((2*m*u(N-1)^(m-1))/(h));


%f(1)=(u(2)^m-2*u(1)^m+((4*u(1)^m-u(2)^m))/3)/(h*h);
%f(N)=u(N)^p-(3*u(N)^m-4*u(N-1)^m+u(N-2)^m)/(2*h);

for n= 2:1:N-1
    a(n,1)= Mat(n)-aa*tau*((-m*u(n)^(m-1)*2)/(h*h));
    b(n,1)= 0-aa*tau*((m*u(n-1)^(m-1))/(h*h));
    c(n,1)= 0-aa*tau*((m*u(n+1)^(m-1))/(h*h));
    
  %   f(n)=(u(n+1)^m-2*u(n)^m+u(n-1)^m)/(h*h);
end
coef =0-aa*tau*((-1)*(m*u(N-2)^(m-1))/(2*h));
coeff= b(N-1,1)/coef;
  
     b(N,1)=a(N-1,1)-coeff*b(N,1);
     a(N,1)=c(N-1,1)-coeff*a(N,1);
  %   f(N)=f(N-1)-coeff*f(N);
     
 

          
%f(1,1)=(-2*m*u(1)^(m-1))/(3*h*h);
%f(1,2)=(2*m*u(2)^(m-1))/(3*h*h);
%f(N,N)=(p*u(N)^(p-1))- (3*m*u(N)^(m-1))/(2*h);
%f(N,N-1)=(2*m*u(N-1)^(m-1))/(h);
% for n= 2:1:N-1
%     f(n,n)= (-m*u(n)^(m-1)*2)/(h*h);
%     f(n,n-1)=(m*u(n-1)^(m-1))/(h*h);
%     f(n,n+1)=(m*u(n+1)^(m-1))/(h*h);
% end
%f(N,N-2)=(-1)*(m*u(N-2)^(m-1))/(2*h);






end

