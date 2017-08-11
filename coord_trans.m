function points_trans = coord_trans(points)
%COORD_TRANS Summary of this function goes here
%   Detailed explanation goes here
% Lidar pose w.r.t Global, G2L: Global to Lidar
d2r = pi/180;
tr_vec_G2L =[-0.15, -22.1, 6.5];
eul_angles_G2L = [-50.0, 25.0, 120.0] * d2r;

H_G2L = homotrafo(eul_angles_G2L, tr_vec_G2L);
%H_L2G = inv(H_G2L);

% Stereo Unit w.r.t Global, G2S: Global to Stereo
tr_vec_G2S = [-0.15,-22.2,6.3];
eul_angles_G2S = [-50.0,15.0,120.0] * d2r;
H_G2S = homotrafo(eul_angles_G2S, tr_vec_G2S);

% Left camera w.r.t to Stereo Unit, S2L: Stereo to Left Camera

tr_vec_S2LC = [0.10, 0.20, 0.0];
eul_angles_S2LC = [0.0, 0.0, 0.0];
H_S2LC = homotrafo(eul_angles_S2LC, tr_vec_S2LC);

% Transformation from Lidar to Left Camera
H_L2LC = H_G2L \ H_G2S * H_S2LC;

XYZ = points(:, 1:3);
range = points(:, 4);
%XYZ = lidar_bg_xyz
rows = size(XYZ,1);
XYZ_aug = [XYZ,ones(rows,1)];
XYZ_aug_t = XYZ_aug';
XYZ_aug_t_cam = inv(H_L2LC) * XYZ_aug_t; %%
XYZ1_aug_cam = XYZ_aug_t_cam';
XYZ_cam = XYZ1_aug_cam(:,1:3);
points_trans = [XYZ_cam, range];

end

