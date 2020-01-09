clear all;
clc; 
close all;

file11 = 'right_knee_Session1_Shimmer_41EA_Calibrated_PC.csv';
size11 = 20500;
q11w=xlsread(file11,'K:K');
q11x=xlsread(file11,'L:L');
q11y=xlsread(file11,'M:M');
q11z=xlsread(file11,'N:N');
q11(:,:) = zeros(size11,4); %[1 0 0 0];
q11_inv(:,:) = zeros(size11,4);
q11(1,:) = [1 0 0 0];
q11_inv(1,:) = [1 0 0 0];
for i=1:size11
    if (q11w(i) == 0 && q11x(i) == 0 && q11y(i) == 0 && q11z(i) == 0)
        if (i>1)
        q11(i,:) = q11(i-1,:);
        q11_inv(i,:) = q11_inv(i-1,:);
        end
    else    
    q11(i,:) = [q11w(i) q11x(i) q11y(i) q11z(i)];
    q11_inv(i,:) = [q11w(i) -q11x(i) -q11y(i) -q11z(i)];
    end
end 
q11 = quaternProd(q0_inv,q11);
euler11 = quatern2euler(q11);

file22 = 'right_knee_Session1_Shimmer_5F42_Calibrated_PC.csv';
size22 = 20500;
q22w=xlsread(file22,'K:K');
q22x=xlsread(file22,'L:L');
q22y=xlsread(file22,'M:M');
q22z=xlsread(file22,'N:N');
q22(:,:) = zeros(size22,4); %[1 0 0 0];
q22_inv(:,:) = zeros(size22,4);
q22(1,:) = [1 0 0 0];
q22_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q22w(i) == 0 && q22x(i) == 0 && q22y(i) == 0 && q22z(i) == 0)
        if (i>1)
        q22(i,:) = q22(i-1,:);
        q22_inv(i,:) = q22_inv(i-1,:);
        end
    else    
    q22(i,:) = [q22w(i) q22x(i) q22y(i) q22z(i)];
    q22_inv(i,:) = [q22w(i) -q22x(i) -q22y(i) -q22z(i)];
    end
end 
q22 = quaternProd(q11_inv,q22);
euler22 = quatern2euler(q22);

figure (3);
title('Thigh Shank L')
plot(euler22(tracking,1)*180.0/pi,'-r');
hold on;
plot(euler22(tracking,2)*180.0/pi,'-g');
hold on;
plot(euler22(tracking,3)*180.0/pi,'-b');
grid on;
legend('Right Knee Flexion/Extension', 'Right Knee Abduction/Adduction','Right Internal/External Rotation');

