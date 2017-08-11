function rot = rottrafo(eul_angles)
eul_x = eul_angles(1);
eul_y = eul_angles(2);
eul_z = eul_angles(3);
rot_x = [1 0 0;0 cos(eul_x) -sin(eul_x);0 sin(eul_x) cos(eul_x)];% rotation matrix respect to x
rot_y = [cos(eul_y) 0 sin(eul_y);0 1 0;-sin(eul_y) 0 cos(eul_y)];% rotation matrix respect to y
rot_z = [cos(eul_z) -sin(eul_z) 0;sin(eul_z) cos(eul_z) 0;0 0 1];% rotation matrix respect to z
rot = rot_z * rot_y * rot_x;% rotation matrix according to the ZYX euler angle
