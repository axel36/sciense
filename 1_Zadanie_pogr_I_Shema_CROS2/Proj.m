clear;
clc;

aa=(1+1i)/2;% ���������� ����� ����������
 e0=200;% 2/����� ����� 
 s=10;% ���-�� ��������
 a=1;%��������� �������� 
 U=3;%��������� �������� �������
 
    %���� , ������� ������� �����
  for m = 1:1:s  
      m
    z=1;%����� ��� ������ �� ���� ������
    n=1;%�������� � ���� �����( ��� �� ��� ������ ������ ����� ��������) 
    b=500*a; % ��������� ���-�� ���������� !!!!!!
    T=3/b;% ��� 
    U=3;%��������� �������� �������
    X(m)=b;% ���������� �������(��������) ��� ���������� ������� loglog( N, R) 

 %����, ������� ��������� �������� �������
    for t= -1:T:2  
        if m == 1 % ����� ������ �����
         UU(m,n)=U;% �����������
         q=n;%������� ���-�� ���� � ������ �����
        end
        
        if m > 1
            if rem(n,a)== 1 %������� �� ����� �� ����������� =1(�������� �� ��������� ������ ������ ��������)
            UU(m,z)=U;% ��������� ������� ��������  
            N(m,z)=n;
          	z=z+1;%������� ��� ���� ��������
            end
        end
           
        w=(e0*U*(t+T/2-U))/(1-aa*T*e0*(t-2*U));%���� �����
        W=real(w);
        U=U+T*W;% ��������� ������ ��������                
        
        n=n+1;
    end 
    a=a*2;%���� �������� �����
    
  end
  
 r=2; %�������� ��������
 ff=1;%������ � ������� �������� �
 v=1;%������ � ������ R, ���������� �� 3-� ��������(��� ������� � ������ �������)
 pp=2;%��������� ������� ��������

 %���� ��� ���������� U � ������ � R   1 ���� ( 1-� �������)
 for k= ff:1:s-1
    R(k,:)=(UU(k+1,:)-UU(k,:))/(r^pp-1);%��������� R
    Uu(k,:)=UU(k+1,:)+R(k,:);%��������� ������ ���������� ��������
    dD(k,1)=sqrt(sum(R(k,:).*R(k,:)))/sqrt(sum(Uu(k,:).*Uu(k,:)))*100;%������������� �����������
    Y(1,k)=sqrt(sum(R(k,:).*R(k,:)));%�������� ��� ���������� ������� ( ����� ������� ������)
 end
 %���� ��� P���   1 ����                                                          
 for k=ff:1:s-2
     h=sqrt(sum(R(k,:).*R(k,:)))/sqrt(sum(R(k+1,:).*R(k+1,:)));%��������� Rn � Rn+1
     p(k,1)=log(h)/log(r); %�������������� ���� �                                       
 end
 % ������ ���� ��� P��� , U, R (��������� �������)
 while ff<s-1
     v=v+1;
    ff=ff+1;
    pp=pp+1;%���������� �������� ��� ������ ��������
     
    for k= ff:1:s-1
        R(k,:,v)= (Uu(k+1-ff+1,:,v-1)-Uu(k-ff+1,:,v-1))/(r^pp-1);%��������� R
        Uu(k,:,v)=Uu(k-ff+2,:,v-1)+R(k,:,v);%��������� ������ ���������� ��������
        dD(k,v)=sqrt(sum(R(k,:,v).*R(k,:,v)))/sqrt(sum(Uu(k,:,v).*Uu(k,:,v)))*100;%������������� �����������
        Y(v,k)=sqrt(sum(R(k,:,v).*R(k,:,v)));%�������� ��� ���������� ������� ( ����� ������� R)
    end
    
    for k=ff:1:s-2
         h=sqrt(sum(R(k+1,:,v).*R(k+1,:,v)))/sqrt(sum(R(k,:,v).*R(k,:,v)));
         p(k,v)=log(h)/log(r)*(-1);      %��������� ������� � �                                  
    end
   
 end
  color = ['b';'r'];%����
 
  %���� ���������� ��������
 for k= 1:1:s-1
   
    
t=rem(k,2)+1;% ��� ����� ������
VarX=X(k:s-1);%����� ������ ��� �������� � ������� � ����������� ��������
VarY=Y(k,k:s-1);%����� ������ �������� � ������� � ������� ������� R
 loglog(VarX,VarY,color(t)) ;%������

 hold on  %���� �� ������
 end

     
  p  %����� �
 dD;
%plot(X,Y,'-*b')