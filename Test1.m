clear all;
clc; 
close all;

file = 'default_exp_Session13_Shimmer_5FC5_Calibrated_PC.csv';%Sensor 1: Lower Back
size = 13000;% No. of rows in the schimmer file
tracking = 300:size;
tracking_end = 900;

q0w=xlsread(file,'K:K');%Quaternion coordinates in columns K,L,M,N
q0x=xlsread(file,'L:L');
q0y=xlsread(file,'M:M');
q0z=xlsread(file,'N:N');
q0(:,:) = zeros(size,4);%[0 0 0 0]
q0_inv(:,:) = zeros(size,4);%[0 0 0 0]
q0(1,:) = [1 0 0 0];% Matrix formation
q0_inv(1,:) = [1 0 0 0];% Inverse matrix formation 
for i=1:size
    if (q0w(i) == 0 && q0x(i) == 0 && q0y(i) == 0 && q0z(i) == 0)
        if (i>1)
        q0(i,:) = q0(i-1,:);
        q0_inv(i,:) = q0_inv(i-1,:);
        end
    else    
    q0(i,:) = [q0w(i) q0x(i) q0y(i) q0z(i)];% Assign quarterion coordinates to variables
    q0_inv(i,:) = [q0w(i) -q0x(i) -q0y(i) -q0z(i)];% Assign inverse
    end
end 
euler = quatern2euler(q0);% Quarterion to Euler conversion

figure (1);
title('Hip');
plot(euler(tracking,1)*180.0/pi,'-b');% Flexion/ Extension
hold on;
plot(euler(tracking,2)*180.0/pi,'-r');% Abduction/ Adduction
plot(euler(tracking,3)*180.0/pi,'-g');
grid on;
legend('Flexion/Extension', 'Abduction/Adduction','Internal/External Rotation');

file1 = 'default_exp_Session13_Shimmer_9008_Calibrated_PC.csv';
size1 = 13000;
q1w=xlsread(file1,'K:K');
q1x=xlsread(file1,'L:L');
q1y=xlsread(file1,'M:M');
q1z=xlsread(file1,'N:N');
q1(:,:) = zeros(size1,4); %[1 0 0 0];
q1_inv(:,:) = zeros(size1,4);
q1(1,:) = [1 0 0 0];
q1_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q1w(i) == 0 && q1x(i) == 0 && q1y(i) == 0 && q1z(i) == 0)
        if (i>1)
        q1(i,:) = q1(i-1,:);
        q1_inv(i,:) = q1_inv(i-1,:);
        end
    else    
    q1(i,:) = [q1w(i) q1x(i) q1y(i) q1z(i)];
    q1_inv(i,:) = [q1w(i) -q1x(i) -q1y(i) -q1z(i)];
    end
euler1 = quatern2euler(q1);
end 
q1 = quaternProd(q0_inv,q1);

file11 = 'default_exp_Session13_Shimmer_41EA_Calibrated_PC.csv';
size11 = 8000;
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

figure (2);
title('Hip Thigh')
plot(euler1(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler1(tracking,2)*180.0/pi,'-r');
hold on;
plot(euler1(tracking,3)*180.0/pi,'-g');
hold on;
plot(euler11(tracking,1)*180.0/pi,'-c');
hold on;
plot(euler11(tracking,2)*180.0/pi,'-m');
hold on;
plot(euler11(tracking,3)*180.0/pi,'-y');
grid on;
legend('Left hip Flexion/Extension', 'Left hip Abduction/Adduction','Left Internal/External Rotation','Right hip Flexion/Extension', 'Right hip Abduction/Adduction','RightInternal/External Rotation');

%Store angles
Left_Hip_FlexExt = euler1(tracking,1)*180.0/pi;
Left_Hip_AbdAdd = euler1(tracking,2)*180.0/pi;
Left_Hip_IntExt = euler1(tracking,3)*180.0/pi;

Right_Hip_FlexExt = euler11(tracking,1)*180.0/pi;
Right_Hip_AbdAdd = euler11(tracking,2)*180.0/pi;
Right_Hip_IntExt = euler11(tracking,3)*180.0/pi;

file2 = 'default_exp_Session1_Shimmer_9008_Calibrated_PC.csv';
size2 = 8000;
q2w=xlsread(file2,'K:K');
q2x=xlsread(file2,'L:L');
q2y=xlsread(file2,'M:M');
q2z=xlsread(file2,'N:N');
q2(:,:) = zeros(size2,4); %[1 0 0 0];
q2_inv(:,:) = zeros(size2,4);
q2(1,:) = [1 0 0 0];
q2_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q2w(i) == 0 && q2x(i) == 0 && q2y(i) == 0 && q2z(i) == 0)
        if (i>1)
        q2(i,:) = q2(i-1,:);
        q2_inv(i,:) = q2_inv(i-1,:);
        end
    else    
    q2(i,:) = [q2w(i) q2x(i) q2y(i) q2z(i)];
    q2_inv(i,:) = [q2w(i) -q2x(i) -q2y(i) -q2z(i)];
    end
end 
file22 = 'default_exp_Session1_Shimmer_5F42_Calibrated_PC.csv';
size22 = 8000;
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
q2 = quaternProd(q1_inv,q2);
euler2 = quatern2euler(q2);
q22 = quaternProd(q11_inv,q22);
euler22 = quatern2euler(q22);

figure (3);
title('Thigh Shank L')
plot(euler2(tracking,1)*180.0/pi,'.b');
hold on;
plot(euler2(tracking,2)*180.0/pi,'.r');
hold on;
plot(euler2(tracking,3)*180.0/pi,'.g');
hold on;
plot(euler22(tracking,1)*180.0/pi,'-c');
hold on;
plot(euler22(tracking,2)*180.0/pi,'-m');
hold on;
plot(euler22(tracking,3)*180.0/pi,'-y');
grid on;
legend('Left Knee Flexion/Extension', 'Left Knee Abduction/Adduction','Left Internal/External Rotation','Right Knee Flexion/Extension', 'Right Knee Abduction/Adduction','Right Internal/External Rotation');

%Store values
Left_KneeFlexExt = euler2(tracking,1)*180.0/pi;
Left_KneeAbdAdd = euler2(tracking,2)*180.0/pi;
Left_KneeIntExt = euler2(tracking,3)*180.0/pi;
Right_KneeFlexExt = euler22(tracking,1)*180.0/pi;
Right_KneeAbdAdd = euler22(tracking,2)*180.0/pi;
Right_KneeIntExt = euler22(tracking,3)*180.0/pi;

file3 = 'default_exp_Session1_Shimmer_5FE1_Calibrated_PC.csv';
size3 = 8000;
q3w=xlsread(file3,'K:K');
q3x=xlsread(file3,'L:L');
q3y=xlsread(file3,'M:M');
q3z=xlsread(file3,'N:N');
% q3 = [q3w q3x q3y q3z];
q3(:,:) = zeros(size3,4); %[1 0 0 0];
q3_inv(:,:) = zeros(size3,4);
q3(1,:) = [1 0 0 0];
q3_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q3w(i) == 0 && q3x(i) == 0 && q3y(i) == 0 && q3z(i) == 0)
        if (i>1)
        q3(i,:) = q3(i-1,:);
        q3_inv(i,:) = q3_inv(i-1,:);
        end
    else    
    q3(i,:) = [q3w(i) q3x(i) q3y(i) q3z(i)];
    q3_inv(i,:) = [q3w(i) -q3x(i) -q3y(i) -q3z(i)];
    end
end 
file33 = 'default_exp_Session1_Shimmer_5FC5_Calibrated_PC.csv';
size33 = 8000;
q33w=xlsread(file33,'K:K');
q33x=xlsread(file33,'L:L');
q33y=xlsread(file33,'M:M');
q33z=xlsread(file33,'N:N');
% q3 = [q3w q3x q3y q3z];
q33(:,:) = zeros(size33,4); %[1 0 0 0];
q33_inv(:,:) = zeros(size33,4);
q33(1,:) = [1 0 0 0];
q33_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q33w(i) == 0 && q33x(i) == 0 && q33y(i) == 0 && q33z(i) == 0)
        if (i>1)
        q33(i,:) = q33(i-1,:);
        q33_inv(i,:) = q33_inv(i-1,:);
        end
    else    
    q33(i,:) = [q33w(i) q33x(i) q33y(i) q33z(i)];
    q33_inv(i,:) = [q33w(i) -q33x(i) -q33y(i) -q33z(i)];
    end
end 
q3 = quaternProd(q2_inv,q3);
euler3 = quatern2euler(q3);
q33 = quaternProd(q22_inv,q33);
euler33 = quatern2euler(q33);

figure (4);
title('Shank Foot L');
plot(euler3(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler3(tracking,2)*180.0/pi,'-r');
hold on;
plot(euler3(tracking,3)*180.0/pi,'-g');
hold on;
plot(euler33(tracking,1)*180.0/pi,'-c');
hold on;
plot(euler33(tracking,2)*180.0/pi,'-m');
hold on;
plot(euler33(tracking,3)*180.0/pi,'-y');
grid on;
legend('Left ankle rotation', 'Left dorsiflexion','Left foot progression','Right ankle rotation', 'Right dorsiflexion','foot progression');
% 

% Store values
Left_AnkleRot = euler3(tracking,1)*180.0/pi;
Left_Ankledors = euler3(tracking,2)*180.0/pi;
Left_Ankleprog = euler3(tracking,3)*180.0/pi;
Right_AnkleRot = euler33(tracking,1)*180.0/pi;
Right_Ankledors = euler33(tracking,2)*180.0/pi;
Right_Ankleprog = euler33(tracking,3)*180.0/pi;


%store peak angles
%Max_Angle = [max(Left_Hip_FlexExt), max(Left_Hip_AbdAdd),max(Left_Hip_IntExt),max(Left_KneeFlexExt), max(Left_KneeAbdAdd), max(Left_KneeIntExt), max(Left_AnkleRot) , max(Left_Ankledors), max(Left_Ankleprog)];

%Min_Angle = [min(Left_Hip_FlexExt), min(Left_Hip_AbdAdd),min(Left_Hip_IntExt),min(Left_KneeFlexExt), min(Left_KneeAbdAdd), min(Left_KneeIntExt), min(Left_AnkleRot) , min(Ankledors), min(Left_Ankleprog)];
