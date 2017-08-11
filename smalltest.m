d2r = pi/180.0; % pi/180.0
lidar_bg = csvread('background.csv');% background, no car in the FoV
lidar_bg_xyz = lidar_bg(:,1:3);
figure;
pcshow(lidar_bg_xyz);
title('background in local');

% with a car in the FoV
lidar1 = csvread('1.csv');%1501326824.032158.csv
lidar1_xyz = lidar1(:,1:3);
figure;
pcshow(lidar1_xyz);
title('a car in local');

% diff = lidar_bg_xyz - lidar1_xyz;
% figure;
% pcshow(diff);

%% test
% tr_vec= [1 1 0];
% eul_angles = [0 0 0];
%% real transition and rotation
tr_vec= [-0.15 -22.1 6.5];% respect to global
eul_angles = [-50.0,25.0,120.0]*d2r; % respect to global
H = homotrafo(eul_angles, tr_vec);

%% homotrafo function
% eul_x = eul_angles(1);
% eul_y = eul_angles(2);
% eul_z = eul_angles(3);
% rot_x = [1 0 0;0 cos(eul_x) -sin(eul_x);0 sin(eul_x) cos(eul_x)];% rotation matrix respect to x
% rot_y = [cos(eul_y) 0 sin(eul_y);0 1 0;-sin(eul_y) 0 cos(eul_y)];% rotation matrix respect to y
% rot_z = [cos(eul_z) -sin(eul_z) 0;sin(eul_z) cos(eul_z) 0;0 0 1];% rotation matrix respect to z
% rot = rot_z * rot_y * rot_x;% rotation matrix according to the ZYX euler angle
% %rot = eul2rotm(eul_angles);
% H = rotm2tform(rot);% from rotation matrix to homogenous transformation matrix
% H(1:3,4)=tr_vec';% add transition vector to homogenous transformation matrix
% % H\[3 3 0 1;2 2 0 1]';

%% Transformation
% ptCloud_1 = pcread('lidar1.ply'); % In sensor local coordinate
% XYZ = ptCloud_1.Location;
XYZ = lidar1_xyz;
%XYZ = lidar_bg_xyz;
rows = size(XYZ,1);
XYZ1 = [XYZ,ones(rows,1)];
XYZ1_t = XYZ1';
XYZ1_t_global = H * XYZ1_t; %%
XYZ1_global = XYZ1_t_global';
XYZ_global = XYZ1_global(:,1:3);
figure; 
pcshow(XYZ_global);
title('Global');
hold on;
plot3(-7.8515,-10.0,1.1459279, 'r*') % the local of the car


% 
% XYZ1_t_local = H\XYZ1_t;
% XYZ1_local = XYZ1_t_local';
% XYZ_local = XYZ1_local(:,1:3);

% ptCloud_1_local = pcread('XYZ_local.ply');
% subplot(1,2,1);
% pcshow(ptCloud_1_local);
% subplot(1,2,2);
% pcshow(ptCloud_1);

%H_t = trvec2tform(tr_vec)


% beta = pi/2;
% [cos(beta) 0 sin(beta);0 1 0;-sin(beta) 0 cos(beta)]
