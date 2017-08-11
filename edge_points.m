function points_edge = edge_points(points)
%EDGE_POINTS Summary of this function goes here
%   Detailed explanation goes here

pc_xyz = points(:,1:3);
pc_range = points(:, 4);
% figure;
% pcshow(pc(:,1:3));
layers_range = reshape(pc_range, [size(pc_range, 1)/8, 8]);

% range difference for each point compared to its previous point and next point
prev = abs(layers_range - shift_down(layers_range));
next = abs(layers_range - shift_up(layers_range));

% remove first & last row
prev = prev(2:end-1,:);
next = next(2:end-1,:);

% get the discountinuity values for each lidar point
%layers_range = layers_range(2:end-1,:);
X_val = abs(prev - next)./(prev + next);
% normalize vector
X_val = mat2gray(X_val);

% cut out first and last point in each layer in xyz list
pc_xyz = reshape(pc_xyz, [size(pc_xyz, 1)/8, 8, 3]);
pc_xyz = pc_xyz(2:end-1, :, :);
pc_xyz = reshape(pc_xyz, [size(pc_xyz, 1) * size(pc_xyz, 2), 3]);

% attach discontinuity value to xyz points
X_val = reshape(X_val, [], 1);
pc = [pc_xyz, X_val];

% filter points by: discontinuity > threshold
threshold = 0.4;
pc_filtered = pc(pc(:, 4) > threshold, :);
points_edge = pc_filtered(any(pc_filtered(:, 1:3),2),:);

end

