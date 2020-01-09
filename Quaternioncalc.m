clc
clear
%read gait data
%cd('C:/Bahavathy/Experiments/Trials/Largebmi')
filename='1234.csv';
M=csvread(filename);

%find size of data
[n,m]=size(M);

for i=1:n
    for j=1:4:m-3
       
Q=M(i,j:j+3);

%Calculate rotation matrix
R(1,1)=1-2*Q(3)*Q(3)-2*Q(4)*Q(4);
% R(1,1)=((2*Q(1)*Q(1))-1)+(2*Q(2)*Q(2));
R(1,2) = 2*(Q(2)*Q(3) + Q(1)*Q(4));
R(1,3) = 2*(Q(2)*Q(4)-Q(1)*Q(3));  
R(2,1) = 2*Q(2)*Q(3)-Q(1)*Q(4);
R(2,2) = ((2*Q(1)*Q(1))-1)+(2*Q(3)*Q(3));
R(2,3) = 2*(Q(3)*Q(4)+Q(1)*Q(2)); 
R(3,1) = 2*(Q(2)*Q(4)+Q(1)*Q(3));
R(3,2) = 2*(Q(3)*Q(4)-Q(1)*Q(2));
R(3,3) = ((2*Q(1)*Q(1))-1)+(2*Q(4)*Q(4));  

%Defining the limb vector

%Hip
if j==1
LVHip(i,:)=[-R(1,1), -R(1,2), -R(1,3)];
end

%LeftThigh
if j==5
LVLT(i,:)=[-R(1,1), -R(1,2), -R(1,3)];
end

%LeftShank
if j==9
LVLS(i,:)=[-R(1,1), -R(1,2), -R(1,3)];
end

%LeftFoot
if j==13
LVLF(i,:)=[-R(1,1), -R(1,2), -R(1,3)];
end

% %RightThigh
% if j==17
% LVRT(i,:)=[-R(1,1), -R(1,2), -R(1,3)];
% end
% 
% %RightShank
% if j==21
% LVRS(i,:)=[-R(1,1), -R(1,2), -R(1,3)];   
% end
% 
% %RightFoot
% if j==25
%     LVRF(i,:)=[-R(1,1), -R(1,2), -R(1,3)];
% end
    end  
    
%Find angles

%Left
%Left Knee angle
cross(i,1)=LVLT(i,2)*LVLS(i,3)-LVLT(i,3)*LVLS(i,2);
cross(i,2)=LVLT(i,3)*LVLS(i,1)-LVLT(i,1)*LVLS(i,3);
cross(i,3)=LVLT(i,1)*LVLS(i,2)-LVLT(i,2)*LVLS(i,1);

norm(i)= sqrt(cross(i,1)*cross(i,1)+cross(i,2)*cross(i,2)+cross(i,3)*cross(i,3));
dot(i)= LVLT(i,1)*LVLS(i,1)+LVLT(i,2)*LVLS(i,2)+LVLT(i,3)*LVLS(i,3);
angleLknee(i)=(atan2(dot(i),norm(i)))/pi*180;

% %Right Knee angle
% cross(i,1)=LVRT(i,2)*LVRS(i,3)-LVRT(i,3)*LVRS(i,2);
% cross(i,2)=LVRT(i,3)*LVRS(i,1)-LVRT(i,1)*LVRS(i,3);
% cross(i,3)=LVRT(i,1)*LVRS(i,2)-LVRT(i,2)*LVRS(i,1);
% 
% norm(i)= sqrt(cross(i,1)*cross(i,1)+cross(i,2)*cross(i,2)+cross(i,3)*cross(i,3));
% dot(i)= LVRT(i,1)*LVRS(i,1)+LVRT(i,2)*LVRS(i,2)+LVRT(i,3)*LVRS(i,3);
% angleRknee(i)=(atan2(dot(i),norm(i)))/pi*180;

%Left Hip angle
cross(i,1)=LVHip(i,2)*LVLS(i,3)-LVHip(i,3)*LVLS(i,2);
cross(i,2)=LVHip(i,3)*LVLS(i,1)-LVHip(i,1)*LVLS(i,3);
cross(i,3)=LVHip(i,1)*LVLS(i,2)-LVHip(i,2)*LVLS(i,1);

norm(i)= sqrt(cross(i,1)*cross(i,1)+cross(i,2)*cross(i,2)+cross(i,3)*cross(i,3));
dot(i)= LVHip(i,1)*LVLS(i,1)+LVHip(i,2)*LVLS(i,2)+LVHip(i,3)*LVLS(i,3);
angleLHip(i)=(atan2(dot(i),norm(i)))/pi*180;

% % %Right Hip angle
% cross(i,1)=LVHip(i,2)*LVRS(i,3)-LVHip(i,3)*LVRS(i,2);
% cross(i,2)=LVHip(i,3)*LVRS(i,1)-LVHip(i,1)*LVRS(i,3);
% cross(i,3)=LVHip(i,1)*LVRS(i,2)-LVHip(i,2)*LVRS(i,1);
% 
% norm(i)= sqrt(cross(i,1)*cross(i,1)+cross(i,2)*cross(i,2)+cross(i,3)*cross(i,3));
% dot(i)= LVHip(i,1)*LVRS(i,1)+LVHip(i,2)*LVRS(i,2)+LVHip(i,3)*LVRS(i,3);
% angleRHip(i)=(atan2(dot(i),norm(i)))/pi*180;

%Left Ankle
cross(i,1)=LVLF(i,2)*LVLS(i,3)-LVLF(i,3)*LVLS(i,2);
cross(i,2)=LVLF(i,3)*LVLS(i,1)-LVLF(i,1)*LVLS(i,3);
cross(i,3)=LVLF(i,1)*LVLS(i,2)-LVLF(i,2)*LVLS(i,1);

norm(i)= sqrt(cross(i,1)*cross(i,1)+cross(i,2)*cross(i,2)+cross(i,3)*cross(i,3));
dot(i)= LVLF(i,1)*LVLS(i,1)+LVLF(i,2)*LVLS(i,2)+LVLF(i,3)*LVLS(i,3);
angleLankle(i)=(atan2(dot(i),norm(i)))/pi*180;
% 
% %Right Ankle
% cross(i,1)=LVRF(i,2)*LVRS(i,3)-LVRF(i,3)*LVRS(i,2);
% cross(i,2)=LVRF(i,3)*LVRS(i,1)-LVRF(i,1)*LVRS(i,3);
% cross(i,3)=LVRF(i,1)*LVRS(i,2)-LVRF(i,2)*LVRS(i,1);
% 
% norm(i)= sqrt(cross(i,1)*cross(i,1)+cross(i,2)*cross(i,2)+cross(i,3)*cross(i,3));
% dot(i)= LVRF(i,1)*LVRS(i,1)+LVRF(i,2)*LVRS(i,2)+LVRF(i,3)*LVRS(i,3);
% angleRankle(i)=(atan2(dot(i),norm(i)))/pi*180;
end


plot(55-angleLknee,'r')
title('Left knee')
figure()
%hold on
%  plot(70-angleRknee)
%  title('Right Knee')
 %N_004_3= (85-angleRknee(1:980))'
 %csvwrite('N_004_3',N_004_3)
%figure()
%hold on
% plot(90-angleLHip,'g')
% title('Hip (calculated from left leg)')
% figure()
%hold on
plot(80-angleLankle)
title('Left ankle')
figure()
%  plot(80-angleRankle)
%  title('Right ankle')
 %N_ankle_001_1= (80-angleRankle(950:1680))'
 %csvwrite('N_ankle_001_1',N_ankle_001_1)