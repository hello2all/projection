function points_trans = trans_global(points)
%TRANS_GLOBAL Summary of this function goes here
%   Detailed explanation goes here
% Lidar pose w.r.t Global, G2L: Global to Lidar
d2r = pi/180;
tr_vec_G2L =[-0.15, -22.1, 6.5];
eul_angles_G2L = [-50.0, 25.0, 120.0] * d2r;

H_G2L = homotrafo(eul_angles_G2L, tr_vec_G2L);
%H_L2G = inv(H_G2L);

XYZ = points(:, 1:3);
range = points(:, 4);
%XYZ = lidar_bg_xyz
rows = size(XYZ,1);
XYZ_aug = [XYZ,ones(rows,1)];
XYZ_aug_t = XYZ_aug';
XYZ_aug_t_cam = H_G2L * XYZ_aug_t; %%
XYZ1_aug_cam = XYZ_aug_t_cam';
XYZ_cam = XYZ1_aug_cam(:,1:3);
points_trans = [XYZ_cam, range];

end