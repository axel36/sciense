% clear;
% clc;
% 
% load('data.mat');

% u_array - ������ ����������� SxSx(M_0+1)x(N_0+1), ���������� ������� PDE �� ������ ������ � �����, ����������� � ������ ������� �����;
% ������ �������� - ����� ����������� ����� S, �� ������� ����������� �������;
% ������ ������� - ����� ��� �������� ����������� ���������� �������, ������� ��������;
% ������ �������� - ����� ����� M_0+1 ������� ����� �� t; 
% �������� �������� - ����� ����� N_0+1 ������� ����� �� x.

% �.�. ���� �� ������ ����� ��������� ������� u (������ ����������� (M_0+1)x(N_0+1))
% � �� �������� ������ �������� �������� ������� u � ����� ����������� � ������ ������� �����,
% �� ������ u_array ����� ���� �������� ��������� �������: 

% u_array = zeros(S,S,M_0 + 1,N_0 + 1); 
% % ������� ���� (������������� ������� S ��� �� ������ ������)
% % ������ ������� ������� ������ � �����, ����������� � ������ �������� �����
% for s = 1:S 
%     % �������� ������� ������� ��������� ������� ��������� PDE �� ����� � ������� s
%     u = % �������, ������� ��������� ������� ��������� PDE �� ����� � ������� s
%     for m = 1:(M_0+1)
%         for n = 1:(N_0+1)
%             u_array(s,1,m,n) = u(m,n);
%         end
%     end
% end

% % -------------------------------------------------------------------------
% % ��������! ����� ������������� ���������, ������� ���� ������������� ������
% 
% % ����� ��������� ������������� ��������� ������� �� ���������
% p = 2; % ������������� ������� �������� �����
% q = 1;
% r = 2; % ����������� �������� �����
% 
% %t_0 = % ������� ������ �� ������� - ������ ����������� 1x(M_0+1)
% %x_0 = % ������� ������ �� ���������� - ������ ����������� 1x(N_0+1)
% 
% % ----------------------��, ��� ������� � ���----------------------------
u_array = zeros(S,S,M_0 + 1,N_0 + 1); 
t_0 = T_0;
x_0 = X_0;
p = 2; % ������������� ������� �������� �����
q = 1;
r = 2; % ����������� �������� �����
for s = 1:S 
    % �������� ������� ������� ��������� ������� ��������� PDE �� ����� � ������� s
    %u = % �������, ������� ��������� ������� ��������� PDE �� ����� � ������� s
    for m = 1:(M_0+1)
        for n = 1:(N_0+1)
            u_array(s,1,m,n) = u(m,n,s);
        end
    end
end

%--------------------------------------------------------------------------
% ���������� �������� ������� �� ����������
for l = 2:S
    for s = l:S
        for i = 1:(M_0 + 1)
            for j = 1:(N_0 + 1)
                u_array(s,l,i,j) = u_array(s,l-1,i,j) + (u_array(s,l-1,i,j) - u_array(s-1,l-1,i,j))/(r^(p + q*((l - 1) - 1)) - 1);
            end
        end
    end
end

% ��������� ����������� ������� �������� ���������� ������� �� ������ ��������� ����
% m >= 2 (����� �������, ��� ��� �� ��� ������� ������ �����)
figure;
p_eff_ForEveryLayer = zeros(S-2,M_0);
for m = 2:(M_0 + 1)
    for s = 3:S
        R_rN = sqrt(sum((u_array(s,2,m,:)-u_array(s,1,m,:)).^2));
        R_N = sqrt(sum((u_array(s-1,2,m,:)-u_array(s-1,1,m,:)).^2));
        p_eff_ForEveryLayer(s-2,m - 1)= ((log(R_N))-(log(R_rN)))/(log(r));
    end
end
% ������ ����������� �������������� ������� �������� �� ������ ����
%figure
hold on;
plot(t_0(2:M_0+1),t_0(2:M_0+1)*0 + p,'-*k','MarkerSize',3);

% ������ ����������� ������������ ������� �������� �� ������ ����
plot(t_0(2:M_0+1),p_eff_ForEveryLayer(S-2,:),'-sk','MarkerSize',5,'LineWidth',1);
% load('ghjj.mat');
% plot(t_0(2:M_0+1),p_eff_ForEveryLayer(S-2,:),'-*r','MarkerSize',5,'LineWidth',1);
% load('F_dub_8.mat');
% plot(t_0(2:M_0+1),p_eff_ForEveryLayer(S-2,:),'-*g','MarkerSize',5,'LineWidth',1);

hold off;
xlabel('t');
ylabel('p^{eff}');
title('p^{eff} for each time layer');
axis([t_0(2) t_0(length(t_0)) -4 (p+2)]);

%continue

% ��������� ����������� ������� �������� (�� ���� ���������������� ������ ����� ���������) 
% ��������� ������� �� ����������� ��������� ���� � ������� m
p_eff_ForParticularLayer = zeros(S-2,N_0);
 m = 15; % ����� ���������������� ���������� ����
%m = length(t_0); % ����� ���������� ���������� ����
for n = 2:N_0+1
    for s = 3:S
        R_rN = sqrt((u_array(s,2,m,n)-u_array(s,1,m,n)).^2);
        R_N = sqrt((u_array(s-1,2,m,n)-u_array(s-1,1,m,n)).^2);   % ����� ���������� ���� �.� S-2 �����  � ��� ����� �������� 
        p_eff_ForParticularLayer(s-2,n - 1)= ((log(R_N))-(log(R_rN)))/(log(r));
    end
end
figure;
% ������ ����������� �������������� ������� �������� �� ������ ����
plot(x_0(2:N_0+1),x_0(2:N_0+1)*0 + p,'-*k','MarkerSize',3);
hold on;
% ������ ����������� ������������ ������� �������� �� ������ ����
plot(x_0(2:N_0+1),p_eff_ForParticularLayer(S-2,:),'-sk','MarkerSize',5,'LineWidth',1);
hold off;
xlabel('x');
ylabel('p^{eff}');
title('p^{eff} for particular time layer');
axis([x_0(2) x_0(length(x_0)-1) -2 (p+2)]);

% ��������� ���������� ���������� ����� (������� ����������� ������� ��������)
p_total = zeros(S-2,S-2);
for l = 3:S
    for s = l:S
        R_rN = sqrt(sum(sum((u_array(s,l-1,:,:)-u_array(s,l-2,:,:)).^2)));
        R_N = sqrt(sum(sum((u_array(s-1,l-1,:,:)-u_array(s-1,l-2,:,:)).^2)));
        p_total(s-2,l-2)= ((log(R_N))-(log(R_rN)))/(log(r));
    end
end 

% ��������� ���������� ���������� ����� (������� ����������� ������� �������� ��� ����������� ���� ��������� �����)
m = 2;
n = 7;
p_part_1 = zeros(S-2,S-2);
for l = 3:S
    for s = l:S
        R_rN = sqrt((u_array(s,l-1,m,n)-u_array(s,l-2,m,n)).^2);
        R_N = sqrt((u_array(s-1,l-1,m,n)-u_array(s-1,l-2,m,n)).^2);
        p_part_1(s-2,l-2)= ((log(R_N))-(log(R_rN)))/(log(r));
    end
end
p_part_1

% ��������� ���������� ���������� ����� (������� ����������� ������� �������� ��� ���� ����� ����� ������� ����������)
number = 10;
p_part_2 = zeros(S-2,S-2);
for l = 3:S
    for s = l:S
        R_rN = sqrt(sum(sum((u_array(s,l-1,1:number,:)-u_array(s,l-2,1:number,:)).^2)));
        R_N = sqrt(sum(sum((u_array(s-1,l-1,1:number,:)-u_array(s-1,l-2,1:number,:)).^2)));
        p_part_2(s-2,l-2)= ((log(R_N))-(log(R_rN)))/(log(r));
    end
end
p_part_2

% % ������ � ������� ��������������� �������� ������� ������������ ������ ��
% % ����� �����
% figure;
% clear delta;
% clear N_mesh;
% delta = zeros(S-1,S-1);
% N_mesh = zeros(S-1,S-1);
% 
% for l = 1:S-1
%     
%     for s = l:S-1
%         delta(s - l + 1,l) = sqrt(sum(sum((u_array(s+1,l,:,:)-u_array(s,l,:,:)).^2)));
%         N_mesh(s - l + 1,l) = M_0*(r^(s))*N_0*(r^(s));
%     end
%     loglog(N_mesh(:,l),delta(:,l));
%     hold on;
% end
% axis([M_0*(r^1)*N_0*(r^1) M_0*(r^(S-1))*N_0*(r^(S-1)) 0 delta(1,1)]);

% ������������ ������������ ��������, �� ������� �� ������ �����
% ������������ ����������� ������������ ������� �������� �� ����� ����
% ��� ���������� ����, ���������������� ����� �����

%continue; 

figure;

k = 1; % � ����� ������������ ������ k-�� ����
for m = 1:k:M_0+1
    
    % ��������� ����������� ������� �������� (�� ���� ���������������� ������ ����� ���������) 
    % �� ����������� ��������� ���� � ������� m
    p_eff_ForParticularLayer = zeros(S-2,N_0 - 1);
    for n = 2:N_0
        for s = 3:S
            R_rN = sqrt((u_array(s,2,m,n)-u_array(s,1,m,n)).^2);
            R_N = sqrt((u_array(s-1,2,m,n)-u_array(s-1,1,m,n)).^2);
            p_eff_ForParticularLayer(s-2,n - 1)= ((log(R_N))-(log(R_rN)))/(log(r));
        end
    end
    % ������ ����������� �������������� ������� �������� �� ������ ����
    plot(x_0(2:N_0),x_0(2:N_0)*0 + p,'-*k','MarkerSize',3);
    hold on;
    % ������ ����������� ������������ ������� �������� �� ������ ����
    plot(x_0(2:N_0),p_eff_ForParticularLayer(S-2,:),'-sk','MarkerSize',5,'LineWidth',1);
    hold off;
    xlabel('x');
    ylabel('p^{eff}');
    title('p^{eff} for particular time layer');
    axis([x_0(2) x_0(length(x_0)-1) -2 (p+3)]);
    txt2=num2str(t_0(m));
    txt1='time =';
     txt=[txt1 ' ' txt2] ;
     hT = text(1, 3,txt); 
     
    drawnow;
    pause(0.1);
    
    m
    
    frame = getframe(gcf);
    img =  frame2im(frame);
    [img,cmap] = rgb2ind(img,256);
    if m == 1
        imwrite(img,cmap,'animationM.gif','gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(img,cmap,'animationM.gif','gif','WriteMode','append','DelayTime',0.1);
    end
    
    % ��������� ������������ �������� � ����, 
    % ������� ����� ���� ������������ � �����
    %mov((m-1)/k+1) = getframe;
    
end
x=5;
% ��������� ��������� � ������������ ����������� ����������
%movie2avi(mov, 'p_eff1.avi', 'compression', 'None'); %#ok<MOVIE2>

