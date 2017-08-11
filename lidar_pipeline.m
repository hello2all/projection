points_raw = csvread('1.csv');
d2r = pi/180;
eul_angles_G2LC =[-50.0*d2r,15.0*d2r,120.0*d2r]; % stereo camera or left camera w.r.t global coord
tr_vec_G2LC = [-0.28,-22.2150,6.1261];
% eul_angles = [0.0,0.0,0.0]*d2r;

% transfrom raw lidar points into camera's coordinate system

% points_trans = coord_trans(points_raw);
points_trans = trans_global(points_raw);
pcshow(points_trans(:, 1:3))
hold on;
% rot_G2LC = rottrafo(eul_angles_G2LC);
plotCamera('Location',tr_vec_G2LC,'Orientation', angle2dcm(50.0*d2r,-15.0*d2r,-120.0*d2r),'Opacity',0);
% angle2dcm(-50.0*d2r,15.0*d2r,120.0*d2r)
plot3(-0.28,-22.2150,6.1261,'b*');
plot3(-7.8515,-10.0,1.1459279, 'r*') % the local of the car
hold off;

% set(gca,'CameraUpVector',[0 0 -1]);

% preprocess lidar points to get edge points
points_edge = edge_points(points_trans);

figure
pcshow(points_edge(:, 1:3))
hold on
cam = plotCamera('Location',tr_vec_G2LC,'Orientation', angle2dcm(50.0*d2r,-15.0*d2r,-120.0*d2r),'Opacity',0);
% angle2dcm(-50.0*d2r,15.0*d2r,120.0*d2r)
plot3(-0.28,-22.2150,6.1261,'b*');
plot3(-7.8515,-10.0,1.1459279, 'r*') % the local of the car
hold off

% project 3d points to 2d
points_2d = project3to2(points_edge);

%show the projection
figure;
scatter(points_2d(:,1),points_2d(:,2), 10, points_2d(:,3));
xlim([0 256]);
ylim([0 256]);
axis equal;
title('Points projected with camera model');

