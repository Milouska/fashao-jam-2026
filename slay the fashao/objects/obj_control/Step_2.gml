//drawing
if (mouse_check_button(mb_left) && !turn_finished) {
	if (mouse_check_button_pressed(mb_left)) {
		with(obj_token) {
			if (type = TokenType.WISDOM) {
				wisdom_dir_total = 0;
				wisdom_prev_dir = point_direction(x, y, mouse_x, mouse_y);
			}
		}
		
		stamina_cd = stamina * stamina_inc;
	}
	
    var dist = point_distance(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious);
	
	//If we run out of concentration, we stop the movement
	if (game_state == GameState.COMBAT) {
		stamina_cd = approach(stamina_cd, 0, 1);
		stamina_y = lerp(stamina_y, 0, 0.2);
	}
	if (stamina_cd = 0) {
		end_player_turn();
		return
	}
    
    if (dist < 3) return
    
	var line = instance_create_depth(mouse_x, mouse_y, -1, obj_line);
	line.image_angle = point_direction(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious);
	line.image_xscale = dist
	line.image_yscale = 3;

    var collidee = collision_line(mouse_x, mouse_y, mouse_xprevious, mouse_yprevious, obj_token, true, true)
    
    // We ignore wisdom tokens, as those have special detection
    if (collidee && !array_contains(collided_tokens, collidee.id) && collidee.type != TokenType.WISDOM) {
        array_push(collided_tokens, collidee.id)
        collidee.selected = true
        
        // WHile walking, we skip the check
        if (game_state != GameState.COMBAT) {
            end_player_turn()
            return
        }
        
        // If we were using strength OR endurance and the other is hit, we stop the movement
        for (var i = 0; i < array_length(collided_tokens); i++) {
            var element = collided_tokens[i]
            
            if (element.type == TokenType.STRENGTH || element.type == TokenType.ENDUREANCE) {
                if (collided_first_type > -1 && collided_first_type != element.type) {
                    end_player_turn()
                } else {
                    collided_first_type = element.type
                }
            }
        }
    }
} else {
	stamina_y = lerp(stamina_y, -12, 0.2);
}

if (mouse_check_button_released(mb_left) && !turn_finished) {
    if (game_state == GameState.COMBAT) {     
        end_player_turn()
    } else {
        // In other states, we allow free drawing
        with(obj_line) disappear = true;
		with(obj_token) wisdom_dir_total = 0;
    }
}

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;