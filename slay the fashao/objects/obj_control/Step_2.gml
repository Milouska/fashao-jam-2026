//drawing
if (mouse_check_button(mb_left) && !turn_finished) {
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
        
        // If we were using strength OR endurance and the other is hit, we stop the movement
        for (var i = 0; i < array_length(collided_tokens); i++) {
            var element = collided_tokens[i]
            
            if (element.type == TokenType.STRENGTH || element.type == TokenType.ENDUREANCE) {
                show_debug_message(string("started with {0} and now has {1}", collided_first_type, element.type))
                
                if (collided_first_type > -1 && collided_first_type != element.type) {
                    // End movement too
                    end_player_turn()
                }
                
                collided_first_type = element.type
            }
        }
    }
}

if (mouse_check_button_released(mb_left) && !turn_finished) {
    end_player_turn()
}

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;