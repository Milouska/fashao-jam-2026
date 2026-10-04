if (type = TokenType.WISDOM) and (selected = false) and (obj_control.turn_finished = false) and (instance_exists(obj_line)){
	var dir = point_direction(x, y, mouse_x, mouse_y);
	wisdom_dir_total += angle_difference(wisdom_prev_dir, dir);
	wisdom_prev_dir = dir;
	
	if (abs(wisdom_dir_total) > 360) {
		with(obj_control){
			array_push(collided_tokens, other.id)
			// WHile walking, we skip the check
	        if (game_state != GameState.COMBAT) {
	            end_player_turn()
	        }
		}
		with(obj_token) {
			if (type = TokenType.WISDOM) {
				wisdom_prev_dir = dir;
				wisdom_dir_total = 0;
			}
		}
		selected = true;
	}
} else {
	wisdom_dir_total = 0;
}
