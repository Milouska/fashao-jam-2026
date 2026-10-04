var thickness = 4;

if (type > 4) thickness = 6;

var bcol = make_color_rgb(100,100,100);

for (var i = 1; i < thickness; i++) {
	draw_sprite_ext(spr_token, type, x, y + i, image_xscale, image_yscale, image_angle, bcol, 1);
}

draw_sprite_ext(spr_token, type, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

if (type = TokenType.WISDOM) {
	var dir = point_direction(x,y,mouse_x,mouse_y);
	var len = 24;
	draw_sprite_ext(spr_line_end, 0, x + lengthdir_x(len,dir), y + lengthdir_y(len,dir), 1, 1, 0, obj_control.wisdom_col, 1);
	
	var step = 6;
	for (var i = 0; i < abs(wisdom_dir_total) / step; i++) {
		draw_sprite_ext(spr_line_end, 0, x + lengthdir_x(len,dir + wisdom_dir_total - i * step * sign(wisdom_dir_total)), y + lengthdir_y(len,dir + wisdom_dir_total - i * step * sign(wisdom_dir_total)), 1, 1, 0, obj_control.wisdom_col, 1);
	}
}

draw_text(x,y+32, wisdom_dir_total);