//drawing
if (mouse_check_button(mb_left)) {
    var dist = point_distance(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious);
    
    if (dist < 10) return
    
	var line = instance_create_depth(mouse_x, mouse_y, 0, obj_line);
	line.image_angle = point_direction(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious);
	line.image_xscale = dist
	line.image_yscale = 3;

    var collidee = collision_line(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious, obj_token, true, true)
    if (collidee && !array_contains(collided_tokens, collidee.id)) {
        array_push(collided_tokens, collidee.id)
        collidee.selected = true
    }
}

if (mouse_check_button_released(mb_left)) {
	with(obj_line) dissapear = true;
}

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;