
% r=2; %�������� ��������
 ff=1;%������ � �
 v=1;%������ �  R, 
 pp=2;%��������� ������� ��������

 %���� ��� ���������� U � ������ � R   1 ���� ( 1-� �������)
 for k= ff:1:s-1
    R(:,:,k)=(u(:,:,k+1)-u(:,:,k))/(r^pp-1);%��������� R
    Uu(:,:,k)=u(:,:,k+1)+R(:,:,k);%��������� ������ ���������� ��������
     dD(k,1)=sqrt(sumsqr(R(:,:,k)))/sqrt(sumsqr(Uu(:,:,k)))*100;%������������� �����������
%     Y(1,k)=sqrt(sum(R(k,:).*R(k,:)));%�������� ��� ���������� ������� ( ����� ������� ������)
 end
 %���� ��� P���   1 ����                                                          
 for k=ff:1:s-2
     H=sqrt(sumsqr(R(:,:,k)))/sqrt(sumsqr(R(:,:,k+1)));%��������� Rn � Rn+1
     p(k,1)=log(H)/log(r); %�������������� ���� �                                       
 end
 %p
%  dD
% ������ ���� ��� P��� , U, R (��������� �������)
 while ff<s-1
     v=v+1;
    ff=ff+1;
    pp=pp+1;%���������� �������� ��� ������ ��������
     
    for k= ff:1:s-1
        R(:,:,k,v)= (Uu(:,:,k-ff+2,v-1)-Uu(:,:,k-ff+1,v-1))/(r^pp-1);%��������� R
        Uu(:,:,k,v)=Uu(:,:,k-ff+2,v-1)+R(:,:,k,v);%��������� ������ ���������� ��������
        dD(k,v)=sqrt(sumsqr(R(:,:,k,v)))/sqrt(sumsqr(Uu(:,:,k,v)))*100;%������������� �����������
%         Y(v,k)=sqrt(sumsqr(R(k,:,v)));%�������� ��� ���������� ������� ( ����� ������� R)
    end
    
    for k=ff:1:s-2
         H=sqrt(sumsqr(R(:,:,k+1,v)))/sqrt(sumsqr(R(:,:,k,v)));
         p(k,v)=log(H)/log(r)*(-1);      %��������� ������� � �                                  
    end
   
 end
 p
 