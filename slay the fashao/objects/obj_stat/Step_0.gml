depth = -20;

image_angle += 18 * spin;

if (life > 0) {
	image_xscale = lerp(image_xscale, 1, 0.2);
	image_yscale = lerp(image_yscale, 1, 0.2);
	life --;
} else {
	if (instance_exists(obj_enemy) and obj_enemy.type = EnemyType.LEECH) {
		x += obj_enemy.x-x*0.2;
		y += obj_enemy.y-y*0.1;
		if (point_distance(x,y,obj_enemy.x,obj_enemy.y) < 32) {
			instance_destroy();
		}
	}else {
		image_xscale = lerp(image_xscale, 0, 0.2);
		image_yscale = lerp(image_yscale, 0, 0.2);
		
		if (image_xscale < 0.01) instance_destroy();
	}
}

switch(type) {
    case TokenType.ENDUREANCE:
        col = obj_control.endurance_col;
        break
    case TokenType.STRENGTH:
        col = obj_control.strength_col;
        break
    case TokenType.WISDOM:
        col = obj_control.wisdom_col;
        break
    case TokenType.STAMINA:
        col = obj_control.stamina_col;
        break
    case TokenType.INTELIGENCE:
        col = obj_control.inteligence_col;
        break
		
	default: col = obj_control.strength_col;
}