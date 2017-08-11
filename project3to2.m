function points_2d = project3to2(points_3d)
%project3to2 project 3d points to 2d points
%   Detailed explanation goes here
% setup camera with focal length 280, centre 128,128
cam = [280,0,128;0,280,128;0,0,1];

%setup image
imageSize = [256,256];

% create a tform matrix
% angles = [45,45,45]*pi/180;
% position = [0,0,0];
angles = [-50.0,15.0,120.0]*pi/180;
% angles = [-5.0,60.0,165.0]*pi/180;
position = [-0.28,-22.2150,6.1261];

tform = eye(4);
tform(1:3,1:3) = angle2dcm(angles(1),angles(2),angles(3));
tform(1:3,4) = position;

%add a little lens distortion
dist = [0.0,0.000];

%project the points into image coordinates
[projected, valid] = projectPoints(points_3d, cam, tform, dist, imageSize, true);
points_2d = projected(valid,:); % ??
% points_2d = projected;
end

