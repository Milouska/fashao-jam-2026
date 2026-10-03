var dir = point_direction(x,y,target_x,target_y)

motion_set(dir, spd);

image_angle = dir - 180;
depth = -2;

if (point_distance(x,y,target_x,target_y) < spd * 2) {
	instance_destroy();
}