camera_set_view_pos(
	view_camera[0], 
	floor(x - (cam_width * 0.5)+random_range(-hshake,hshake)), 
	floor(y - (cam_height * 0.5)+random_range(-vshake,vshake))
)

hshake = approach(hshake, 0, 2);
vshake = approach(vshake, 0, 2);