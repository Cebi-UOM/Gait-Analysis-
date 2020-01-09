clear all;
clc; 
close all;

file = '4831.csv';
size = 25470;
tracking = 300:size;
tracking_end = 900;


q0w=xlsread(file,'K:K');
q0x=xlsread(file,'L:L');
q0y=xlsread(file,'M:M');
q0z=xlsread(file,'N:N');
q0(:,:) = zeros(size,4); %[0 0 0 0];
q0_inv(:,:) = zeros(size,4);
q0(1,:) = [1 0 0 0];
q0_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q0w(i) == 0 && q0x(i) == 0 && q0y(i) == 0 && q0z(i) == 0)
        if (i>1)
        q0(i,:) = q0(i-1,:);
        q0_inv(i,:) = q0_inv(i-1,:);
        end
    else    
    q0(i,:) = [q0w(i) q0x(i) q0y(i) q0z(i)];
    q0_inv(i,:) = [q0w(i) -q0x(i) -q0y(i) -q0z(i)];
    end
end 
euler = quatern2euler(q0);

figure (1);
%title('Hip');
plot(euler(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler(tracking,2)*180.0/pi,'-r');
plot(euler(tracking,3)*180.0/pi,'-g');
grid on;
legend('Flexion/Extension', 'Abduction/Adduction','Internal/External Rotation');

file1 = '9008.csv';
size1 = 25470;
q1w=xlsread(file1,'K:K');
q1x=xlsread(file1,'L:L');
q1y=xlsread(file1,'M:M');
q1z=xlsread(file1,'N:N');
q1(:,:) = zeros(size1,4); %[1 0 0 0];
q1_inv(:,:) = zeros(size1,4);
q1(1,:) = [1 0 0 0];
q1_inv(1,:) = [1 0 0 0];
for i=1:size1
    if (q1w(i) == 0 && q1x(i) == 0 && q1y(i) == 0 && q1z(i) == 0)
        if (i>1)
        q1(i,:) = q1(i-1,:);
        q1_inv(i,:) = q1_inv(i-1,:);
        end
    else    
    q1(i,:) = [q1w(i) q1x(i) q1y(i) q1z(i)];
    q1_inv(i,:) = [q1w(i) -q1x(i) -q1y(i) -q1z(i)];
    end
end 
q1 = quaternProd(q0_inv,q1);
euler1 = quatern2euler(q1);

figure (2);
%title('Hip Thigh L')
plot(euler1(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler1(tracking,2)*180.0/pi,'-r');
plot(euler1(tracking,3)*180.0/pi,'-g');
grid on;
legend('Left hip Flexion/Extension', 'Left hip Abduction/Adduction','Internal/External Rotation');

%Store angles
Left_Hip_FlexExt = euler1(tracking,1)*180.0/pi;
Left_Hip_AbdAdd = euler1(tracking,2)*180.0/pi;
Left_Hip_IntExt = euler1(tracking,3)*180.0/pi;

q2w=xlsread(file,'I:I');
q2x=xlsread(file,'J:J');
q2y=xlsread(file,'K:K');
q2z=xlsread(file,'L:L');
q2(:,:) = zeros(size,4); %[1 0 0 0];
q2_inv(:,:) = zeros(size,4);
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
q2 = quaternProd(q1_inv,q2);
euler2 = quatern2euler(q2);
figure (3);
%title('Thigh Shank L')
plot(euler2(tracking,1)*180.0/pi,'.b');
hold on;
plot(euler2(tracking,2)*180.0/pi,'.r');
plot(euler2(tracking,3)*180.0/pi,'.g');
grid on;
legend('Left Knee Flexion/Extension', 'Left Knee Abduction/Adduction','Internal/External Rotation');

%Store values
KneeFlexExt = euler2(tracking,1)*180.0/pi;
KneeAbdAdd = euler2(tracking,2)*180.0/pi;
KneeIntExt = euler2(tracking,3)*180.0/pi;

q3w=xlsread(file,'M:M');
q3x=xlsread(file,'N:N');
q3y=xlsread(file,'O:O');
q3z=xlsread(file,'P:P');
% q3 = [q3w q3x q3y q3z];
q3(:,:) = zeros(size,4); %[1 0 0 0];
q3_inv(:,:) = zeros(size,4);
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
q3 = quaternProd(q2_inv,q3);
euler3 = quatern2euler(q3);

figure (4);
title('Shank Foot L');
plot(euler3(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler3(tracking,2)*180.0/pi,'-r');
plot(euler3(tracking,3)*180.0/pi,'-g');
grid on;
legend('Left ankle rotation', 'Left dorsiflexion','foot progression');
% 

% Store values
AnkleRot = euler3(tracking,1)*180.0/pi;
Ankledors = euler3(tracking,2)*180.0/pi;
Ankleprog = euler3(tracking,3)*180.0/pi;

%store peak angles
Max_Angle = [max(Left_Hip_FlexExt), max(Left_Hip_AbdAdd),max(Left_Hip_IntExt),max(KneeFlexExt), max(KneeAbdAdd), max(KneeIntExt), max(AnkleRot) , max(Ankledors), max(Ankleprog)];

Min_Angle = [min(Left_Hip_FlexExt), min(Left_Hip_AbdAdd),min(Left_Hip_IntExt),min(KneeFlexExt), min(KneeAbdAdd), min(KneeIntExt), min(AnkleRot) , min(Ankledors), min(Ankleprog)];

q5w=xlsread(file,'M:M');
q5x=xlsread(file,'N:N');
q5y=xlsread(file,'O:O');
q5z=xlsread(file,'P:P');
% q5 = [q5w q5x q5y q5z];
q5(:,:) = zeros(size,4); %[1 0 0 0];
q5_inv(:,:) = zeros(size,4);
q5(1,:) = [1 0 0 0];
q5_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q5w(i) == 0 && q5x(i) == 0 && q5y(i) == 0 && q5z(i) == 0)
        if (i>1)
        q5(i,:) = q5(i-1,:);
        q5_inv(i,:) = q5_inv(i-1,:);
        end
    else    
    q5(i,:) = [q5w(i) q5x(i) q5y(i) q5z(i)];
    q5_inv(i,:) = [q5w(i) -q5x(i) -q5y(i) -q5z(i)];
    end
end 
q5 = quaternProd(q0_inv,q5);
euler5 = quatern2euler(q5);

figure (5);
title('Hip Thigh R');
plot(euler5(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler5(tracking,2)*180.0/pi,'-r');
plot(euler5(tracking,3)*180.0/pi,'-g');
grid on;
legend('Right hip Flexion/Extension', 'Right hip Abduction/Adduction','Internal/External Rotation');
% 
q6w=xlsread(file,'A:A');
q6x=xlsread(file,'B:B');
q6y=xlsread(file,'C:C');
q6z=xlsread(file,'D:D');
% q6 = [q6w q6x q6y q6z];
q6(:,:) = zeros(size,4); %[1 0 0 0];
q6_inv(:,:) = zeros(size,4);
q6(1,:) = [1 0 0 0];
q6_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q6w(i) == 0 && q6x(i) == 0 && q6y(i) == 0 && q6z(i) == 0)
        if (i>1)
        q6(i,:) = q6(i-1,:);
        q6_inv(i,:) = q6_inv(i-1,:);
        end
    else    
    q6(i,:) = [q6w(i) q6x(i) q6y(i) q6z(i)];
    q6_inv(i,:) = [q6w(i) -q6x(i) -q6y(i) -q6z(i)];
    end
end 
q6 = quaternProd(q5_inv,q6);
euler6 = quatern2euler(q6);


figure (6);
title('Thigh Shank R');
plot(euler6(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler6(tracking,2)*180.0/pi,'-r');
plot(euler6(tracking,3)*180.0/pi,'-g');
grid on;
legend('Right Knee Flexion/Extension', 'Right Knee Abduction/Adduction','Internal/External Rotation');
% 
q7w=xlsread(file,'E:E');
q7x=xlsread(file,'F:F');
q7y=xlsread(file,'G:G');
q7z=xlsread(file,'H:H');
% q7 = [q7w q7x q7y q7z];
q7(:,:) = zeros(size,4); %[1 0 0 0];
q7_inv(:,:) = zeros(size,4);
q7(1,:) = [1 0 0 0];
q7_inv(1,:) = [1 0 0 0];
for i=1:size
    if (q7w(i) == 0 && q7x(i) == 0 && q7y(i) == 0 && q7z(i) == 0)
        if (i>1)
        q7(i,:) = q7(i-1,:);
        q7_inv(i,:) = q7_inv(i-1,:);
        end
    else    
    q7(i,:) = [q7w(i) q7x(i) q7y(i) q7z(i)];
    q7_inv(i,:) = [q7w(i) -q7x(i) -q7y(i) -q7z(i)];
    end
end 
q7 = quaternProd(q6_inv,q7);
euler7 = quatern2euler(q7);

figure (7);
title('Shank Foot R');
plot(euler7(tracking,1)*180.0/pi,'-b');
hold on;
plot(euler7(tracking,2)*180.0/pi,'-r');
plot(euler7(tracking,3)*180.0/pi,'-g');
grid on;
legend('Right ankle rotation', 'Right dorsiflexion','foot progression');

figure (8);
%title('Shank Foot R');
Kneedata=euler2(tracking,1)*180.0/pi;
plot(euler2(tracking,1)*180.0/pi,'.b');
hold on;
plot(euler6(tracking,1)*180.0/pi,'.r');
grid on;
legend('Left Knee Flex/Ext Angle', 'Right Knee Flex/Ext Angle');
