//drawing
if (mouse_check_button(mb_left)) {
	var line = instance_create_depth(mouse_x, mouse_y, 0, obj_line);
	line.image_angle = point_direction(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious);
	line.image_xscale = point_distance(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious);
	line.image_yscale = 3;
}

if (mouse_check_button_released(mb_left)) {
	with(obj_line) dissapear = true;
}

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;